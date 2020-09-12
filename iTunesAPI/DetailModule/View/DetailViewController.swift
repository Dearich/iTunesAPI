//
//  DetailViewController.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var presenter: DetailPresenter?
  var isPlaying = false {
    didSet {
      if !isPlaying {
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
      } else {
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
      }
    }
  }
  let celIdentifier = "DetailCell"
  
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var songNameLabel: UILabel!
  @IBOutlet weak var playerView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var smallImage: UIImageView!
  @IBOutlet weak var musicDownloadSpinner: UIActivityIndicatorView!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    spinner.isHidden = true
    navigationController?.navigationBar.prefersLargeTitles = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: celIdentifier)
    tableView.sectionIndexColor = .red
    addBlur()
    smallImage.layer.masksToBounds = true
    smallImage.layer.cornerRadius = 7
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    presenter?.getSongs(comletion: { [weak self] (songs) in
      self?.presenter?.songs = songs
    })
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    presenter?.avHelper?.stop()
  }
  
  func addBlur() {
    let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = playerView.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    playerView.addSubview(blurEffectView)
    playerView.sendSubviewToBack(blurEffectView)
  }
  
  @IBAction func playButtonTapped(_ sender: UIButton) {
    
    if self.isPlaying {
      presenter?.avHelper?.pause()
      presenter?.timer?.invalidate()
    } else {
      guard let isAlredyDownloaded = presenter?.avHelper?.alredyDownloaded else { return }
      if isAlredyDownloaded {
        presenter?.avHelper?.play()
        presenter?.startTimer()
        
      } else {
        musicDownloadSpinner.startAnimating()
        playButton.isEnabled  = false
        nextButton.isEnabled = false
        CheckInternet.shared.checkInternetConnection(completion: { [weak self] (bool) in
          guard let self = self else { return }
          if bool {
            self.presenter?.avHelper?.queueTrack { [weak self] in
              guard let self = self else { return }
              self.presenter?.avHelper?.play()
              self.presenter?.startTimer()
              self.songNameLabel.text = self.presenter?.avHelper?.getCurrentTrackName()
              self.smallImage.image = self.presenter?.image
              self.musicDownloadSpinner.stopAnimating()
              self.playButton.isEnabled = true
              self.nextButton.isEnabled = true
            }
            //            self.isPlaying = !self.isPlaying
          } else {
            self.setupAlert(title: "Lost Connection", message: "Check your internet connection", complition: nil)
          }
        })
      }
    }
    isPlaying = !isPlaying
  }
  
  @IBAction func nextTapped(_ sender: UIButton) {
    
    musicDownloadSpinner.startAnimating()
    playButton.isEnabled  = false
    nextButton.isEnabled = false
    CheckInternet.shared.checkInternetConnection(completion: { [weak self] (bool) in
      guard let self = self else { return }
      if bool {
        self.presenter?.avHelper?.nextSong(songFinishedPlaying: true, comlition: { [weak self] in
          guard let self = self else { return }
          self.songNameLabel.text = self.presenter?.avHelper?.getCurrentTrackName()
          self.smallImage.image = self.presenter?.image
          self.presenter?.avHelper?.play()
          self.presenter?.startTimer()
          self.isPlaying = true
          self.musicDownloadSpinner.stopAnimating()
          self.playButton.isEnabled = true
          self.nextButton.isEnabled = true
        })
      } else {
        self.setupAlert(title: "Lost Connection", message: "Check your internet connection", complition: nil)
      }
    })
  }
}
