//
//  DetailPresenter.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

class DetailPresenter {
  
  weak var view: DetailViewController?
  var album: Album?
  required init (view: DetailViewController) {
    self.view = view
  }
}
