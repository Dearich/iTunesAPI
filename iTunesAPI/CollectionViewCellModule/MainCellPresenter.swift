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
  var album: Album? {
    didSet {
      setupCell()
    }
  }
  
  required init(view: MainCollectionViewCell) {
    self.view = view
  }
  
  func getAlbumImage(with completion: @escaping (Result<UIImage,Error>) -> Void) {
    guard let urlString = album?.imageUrl,
      let url = URL(string: urlString) else { return }
    ImageService.getImageFromCashe(withURL: url) { (image, error) in
      if let image = image {
        completion(.success(image))
      } else if let error = error {
        completion(.failure(error))
      }
    }
  }
  
  func setupCell() {
    guard let album = album,
      let imageView = view?.imageView, let urlString = album.imageUrl else { return }
    view?.albumNameLabel.text = album.albumName
    view?.songsCounterLabel.text = album.artist
    let date = album.releaseDate?.components(separatedBy: "-")
    view?.yearLabel.text = date?[0]
    imageView.image = UIImage(named: "music-placeholder")
    
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DownloadImage"),
                                    object: self,
                                    userInfo: ["imageView": imageView,
                                               "imageUrl": urlString] )
    
  }
}
