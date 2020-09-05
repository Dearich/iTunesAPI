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
  var isPlaying = false
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    spinner.isHidden = true
    navigationController?.navigationBar.prefersLargeTitles = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: celIdentifier)
    addBlur()
    smallImage.layer.masksToBounds = true
//    playButton.isEnabled = false
    smallImage.layer.cornerRadius = 7
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    presenter?.getSongs(comletion: { [weak self] (songs) in
      self?.presenter?.songs = songs
    })
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
    if isPlaying {
      sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
      presenter?.avHelper?.pause()
      presenter?.timer?.invalidate()
    } else {
      sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
      //TODO Bug Fix
      presenter?.avHelper?.queueTrack { [weak self] in
        self?.presenter?.avHelper?.play()
        self?.presenter?.startTimer()
        self?.songNameLabel.text = self?.presenter?.avHelper?.getCurrentTrackName()
        self?.smallImage.image = self?.presenter?.image

      }
    }
    isPlaying = !isPlaying
  }
  
  @IBAction func nextTapped(_ sender: UIButton) {
      presenter?.avHelper?.nextSong(songFinishedPlaying: false, comlition: { [weak self] in
        self?.songNameLabel.text = self?.presenter?.avHelper?.getCurrentTrackName()
        self?.smallImage.image = self?.presenter?.image
        self?.presenter?.avHelper?.play()
        self?.presenter?.startTimer()

      })
    }
}
