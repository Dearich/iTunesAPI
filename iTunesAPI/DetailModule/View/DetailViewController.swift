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

  var songs:[Song]? {
    didSet {
      tableView.reloadData()
    }
  }
  private let celIdentifier = "DetailCell"

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songs = [Song]()
    spinner.isHidden = true
    navigationController?.navigationBar.prefersLargeTitles = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: celIdentifier)
  }

  override func viewWillAppear(_ animated: Bool) {
    presenter?.getSongs(comletion: { [weak self] (songs) in
      self?.songs = songs
    })
  }
}

extension DetailViewController:UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return songs?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: celIdentifier, for: indexPath)
    cell.textLabel?.text = "\(indexPath.row + 1)  \(songs?[indexPath.row].trackName ?? "nil")"
    return cell
  }
}

extension DetailViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 130
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
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
    albumNameLabel.font = .boldSystemFont(ofSize: 17)
    albumNameLabel.numberOfLines = 2
    albumNameLabel.text = presenter?.album?.albumName
    albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
    albumNameLabel.textAlignment = .left
    headerView.addSubview(albumNameLabel)
    albumNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15).isActive = true
    albumNameLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -20).isActive = true
    albumNameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
    albumNameLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true

    let artistNameLabel = UILabel(frame: .zero)
    artistNameLabel.font = .systemFont(ofSize: 15)
    artistNameLabel.numberOfLines = 1
    artistNameLabel.textColor = .systemRed
    artistNameLabel.text = presenter?.album?.artist
    artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
    artistNameLabel.textAlignment = .left
    headerView.addSubview(artistNameLabel)
    artistNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15).isActive = true
    artistNameLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -20).isActive = true
    artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 8).isActive = true
    artistNameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    
    return headerView
  }

//  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return 0
//  }
  func tableView(_ tableView: UITableView,  viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    
    return  view
  }

}
