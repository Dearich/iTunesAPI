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
  required init (view: DetailViewController) {
    self.view = view
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
            //            if songs.resultCount != 0 {
            comletion(songs)

          case .failure(let error):
            self?.view?.setAlert(title: "Error", message: error.localizedDescription)
          }
          self?.view?.spinner.stopAnimating()
          self?.view?.spinner.isHidden = true
        }
      }
    }
  }
}
