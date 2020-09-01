//
//  MainPresenter.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
class MainPresenter: PresenterProtocol {
  weak var view: ViewProtocol?

  required init(view: ViewProtocol) {
    self.view = view
  }

  func getAlbums(_ searchText: String, complition: @escaping ([Album]) -> Void) {
    NetworkLayer.shared.getAlbums(searchText) { [weak self] (result) in
      switch result {
      case .success(let artist):
        complition(artist.albums)

      case .failure(let error):
        self?.setAlert(title: "Error", message: "\(error.localizedDescription)")
      }
    }
  }
}

extension MainPresenter {
  private func setAlert(title: String, message: String) {

    let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default)
    alert.addAction(action)
    guard let view  = view as? MainViewController else { return }
    view.present(alert, animated: true)

  }
}
