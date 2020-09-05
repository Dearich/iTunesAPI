//
//  Ex.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import AVKit

extension DetailViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 140
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

    let headerView =  UIView()
    headerView.backgroundColor = .systemBackground

    let separator = UIView(frame: .zero)
    separator.backgroundColor = #colorLiteral(red: 0.9557611346, green: 0.9558983445, blue: 0.9591422677, alpha: 1)
    separator.translatesAutoresizingMaskIntoConstraints = false
    headerView.addSubview(separator)
    separator.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
    separator.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
    separator.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    separator.heightAnchor.constraint(equalToConstant: 2).isActive = true

    let imageView = UIImageView(frame: .zero)
    imageView.image = presenter?.image
    imageView.backgroundColor = .red
    imageView.translatesAutoresizingMaskIntoConstraints = false
    headerView.addSubview(imageView)
    imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    imageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
    imageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15).isActive = true
    imageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 7

    let albumNameLabel = UILabel(frame: .zero)
    albumNameLabel.font = .boldSystemFont(ofSize: 18)
    albumNameLabel.numberOfLines = 2
    albumNameLabel.text = presenter?.album?.albumName
    albumNameLabel.textAlignment = .left

    let artistNameLabel = UILabel(frame: .zero)
    artistNameLabel.font = .systemFont(ofSize: 16)
    artistNameLabel.numberOfLines = 1
    artistNameLabel.textColor = .systemRed
    artistNameLabel.textAlignment = .left
    artistNameLabel.text = presenter?.album?.artist

    let yearLabel = UILabel(frame: .zero)
    yearLabel.font = .systemFont(ofSize: 15)
    yearLabel.numberOfLines = 1
    yearLabel.textColor = .systemGray2
    yearLabel.textAlignment = .left
    guard let year = presenter?.album?.releaseDate?.components(separatedBy: "-"),
      let genre = presenter?.album?.primaryGenreName
      else { return UIView() }
    yearLabel.text = "\(year[0]) · \(genre)"

    let countLabel = UILabel(frame: .zero)
    countLabel.translatesAutoresizingMaskIntoConstraints = false
    countLabel.font = .systemFont(ofSize: 13)
    countLabel.numberOfLines = 1
    countLabel.textColor = .systemGray2
    countLabel.textAlignment = .left
    let minute = presenter?.songsTime.msToSeconds.minute
    guard let count = presenter?.songs?.count else { return headerView }
    if count > 1 {
      countLabel.text = "\(count) songs, \(minute ?? 0) minutes"
    } else {
      countLabel.text = "\(count) song, \(minute ?? 0) minutes"
    }

    presenter?.setupHeaderLAbels(with: [headerView, imageView, albumNameLabel, artistNameLabel, yearLabel, countLabel], height: 20)
    return headerView
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let url = presenter?.songs?[indexPath.row].previewURL else { return }
    
//    presenter?.playSelectedItem(with: url, indexPath: indexPath.row)
//    let player = AVPlayer(url:URL(string: url)!) // url can be remote or local
//
//    let playerViewController = AVPlayerViewController()
//    // creating a player view controller
//    playerViewController.player = player
//    self.present(playerViewController, animated: true) {
//
//        playerViewController.player!.play()
//    }

  }
}
