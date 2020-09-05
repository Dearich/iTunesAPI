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
    print(albumId)
    DispatchQueue.global(qos: .userInitiated).async {
      NetworkLayer.shared.getSongs(with: albumId) {[weak self] (result) in
        DispatchQueue.main.async {
          switch result {
          case .success(let songs):
            comletion(songs)
            self?.songsTime = songs.map {($0.trackTimeMillis ?? 0)}.reduce(0, { return $0 + $1 })
          case .failure(let error):
            self?.view?.setAlert(title: "Error", message: error.localizedDescription)
          }
          self?.view?.spinner.stopAnimating()
          self?.view?.spinner.isHidden = true
        }
      }
    }
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
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateViewsWithTimer(theTimer:)), userInfo: nil, repeats: true)
  }

@objc func updateViewsWithTimer(theTimer: Timer) {
      updateViews()
  }

  func updateViews() {
    view?.timeLabel.text = avHelper?.getCurrentTimeAsString()
    if let progress = avHelper?.getProgress() {
      print(progress)
//      view?.progressView.progress = progress
    }
  }

//  func playSelectedItem(with url: String, indexPath: Int) {
//    view?.musicDownloadSpinner.startAnimating()
//    avHelper.play(with: url, delegate: self)
//    view?.somgNameLabel.text = songs?[indexPath].trackName
//    view?.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//    view?.smallImage.image = image
//    view?.playButton.isEnabled = true
//    view?.isPlaying = true
//  }
}

//extension DetailPresenter: CachingPlayerItemDelegate {
//  func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
//    avHelper.player.play()
//    DispatchQueue.main.async {
//      self.view?.musicDownloadSpinner.stopAnimating()
//    }
//
//  }
//}

extension TimeInterval {
  var minuteSecondMS: String {
    return String(format:"%d:%02d", minute, second)
  }
  var minute: Int {
    return Int((self/60).truncatingRemainder(dividingBy: 60))
  }
  var second: Int {
    return Int(truncatingRemainder(dividingBy: 60))
  }
  var millisecond: Int {
    return Int((self*1000).truncatingRemainder(dividingBy: 1000))
  }
}

extension Int {
  var msToSeconds: Double {
    return Double(self) / 1000
  }
}
