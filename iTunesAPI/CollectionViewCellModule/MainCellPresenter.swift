//
//  MainCellPresenter.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class MainCellPresenter {

  weak var view: MainCollectionViewCell?
  var album: Album?

  required init(view: MainCollectionViewCell) {
    self.view = view
  }

  func getAlbumImage(with complition: @escaping (Result<UIImage,Error>) -> Void) {
    guard let urlString = album?.imageUrl,
      let url = URL(string: urlString) else { return }
    ImageService.getImageFromCashe(withURL: url) { (image, error) in
      if let image = image {
        complition(.success(image))
      } else if let error = error {
        complition(.failure(error))
      }
    }
  }

  func setupCell() {
    guard let album = album,
      let imageView = view?.imageView, let urlString = album.imageUrl else { return }
    view?.albumNameLabel.text = album.albumName
    view?.songsCounterLabel.text = album.artist
    view?.yearLabel.text = album.releaseDate
    imageView.image = UIImage(named: "music-placeholder")

    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DownloadImage"),
                                       object: self,
                                       userInfo: ["imageView": imageView,
                                                  "imageUrl": urlString] )

  }
}
