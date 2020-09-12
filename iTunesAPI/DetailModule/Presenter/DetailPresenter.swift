//
//  DetailPresenter.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class DetailPresenter {
  
  weak var view: DetailViewController?
  var album: Album?
  var image: UIImage?
  var avHelper: AVHelper?
  var songsTime: Int = 0
  var timer:Timer?
  var songs:[Song]? {
    didSet {
      avHelper = AVHelper(tracks: songs ?? [Song]())
      avHelper?.delegate = self
      avHelper?.aVHelperShowAlertDelegate = self
      view?.tableView.reloadData()
    }
  }
  
  required init (view: DetailViewController) {
    self.view = view
    songs = [Song]()
  }
  
  func getSongs(comletion: @escaping ([Song]) -> Void) {
    view?.spinner.isHidden = false
    view?.spinner.startAnimating()
    guard let albumId = album?.albumId else { return }
    CheckInternet.shared.checkInternetConnection(completion: { [weak self] (bool) in
      guard let self = self else { return }
      if bool {
        DispatchQueue.global(qos: .userInitiated).async {
          NetworkLayer.shared.getSongs(with: albumId) {[weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
              switch result {
              case .success(let songs):
                comletion(songs)
                self.songsTime = songs.map {($0.trackTimeMillis ?? 0)}.reduce(0, { return $0 + $1 })
              case .failure(let error):
                self.view?.setAlert(title: "Error", message: error.localizedDescription)
              }
              self.view?.spinner.stopAnimating()
              self.view?.spinner.isHidden = true
            }
          }
        }
      } else {
        self.view?.setupAlert(title: "Lost Connection", message: "Check your internet connection", complition: nil) 
      }
    })
  }
  
  func setupHeaderLAbels(with views:[UIView], height: CGFloat) {
    for (index,label) in views.enumerated() where label is UILabel {
      label.translatesAutoresizingMaskIntoConstraints = false
      views[0].addSubview(label)
      label.leftAnchor.constraint(equalTo: views[1].rightAnchor, constant: 15).isActive = true
      label.rightAnchor.constraint(equalTo: views[0].rightAnchor, constant: -20).isActive = true
      var topViewIndex = UIView()
      if index == 2 {
        topViewIndex = views[0]
        label.topAnchor.constraint(equalTo: topViewIndex.topAnchor, constant: 20).isActive = true
        
      } else {
        topViewIndex = views[index - 1]
        label.topAnchor.constraint(equalTo: topViewIndex.bottomAnchor, constant: 8).isActive = true
        
      }
      label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(updateViewsWithTimer(theTimer:)),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  @objc func updateViewsWithTimer(theTimer: Timer) {
    updateViews()
  }
  
  func updateViews() {
    view?.timeLabel.text = avHelper?.getCurrentTimeAsString()
    if let progress = avHelper?.getProgress() {
      
      view?.progressView.progress = progress
      
    }
  }
}

extension DetailPresenter : AVHelperProtocol, AVHelperShowAlertProtocol {
  func alertAboutError(errorText: String) {
    view?.setupAlert(title: "Error", message: errorText, complition: nil)
  }
  
  func setupView(with indexPath: Int, lastIndex: Int) {
    guard let song = songs?[indexPath] else { return }
    view?.songNameLabel.text = song.trackName
    let currrentIndexPath = IndexPath(row: indexPath, section: 0)
    let lastIndexPath = IndexPath(row: lastIndex, section: 0)
    view?.tableView.cellForRow(at: lastIndexPath)?.setSelected(false, animated: true)
    view?.tableView.cellForRow(at: currrentIndexPath)?.setSelected(true, animated: true)
    view?.tableView.scrollToRow(at: currrentIndexPath, at: .middle, animated: true)
  }
}

extension UIViewController {
  func setupAlert(title: String, message: String, complition:  ((UIAlertAction) -> Void)?) {
    let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: complition)
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
}
