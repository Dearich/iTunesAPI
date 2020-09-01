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
  private let reuseIdentifier = "MainCell"
  private let historyReuseIdentifier = "HistoryCell"
  private let historyHeader = "Header"

  required init(view: ViewProtocol) {
    self.view = view
  }

  func getAlbums(_ searchText: String, complition: @escaping ([Album]) -> Void) {
    NetworkLayer.shared.getAlbums(searchText.lowercased()) { [weak self] (result) in
      DispatchQueue.main.async {
        switch result {

        case .success(let artist):
          complition(artist.albums)

        case .failure(let error):
          self?.setAlert(title: "Error", message: "\(error.localizedDescription)")
        }
      }
    }
  }

  func setupCollectionView() {
    guard let view = view as? MainViewController else { return }
    view.albums = [Album]()
    view.collectionView.dataSource = view
    view.collectionView.delegate = view
    let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
    view.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    let nib2 = UINib(nibName: "HistoryCollectionViewCell", bundle: nil)
    view.collectionView.register(nib2, forCellWithReuseIdentifier: historyReuseIdentifier)
    let nib3 = UINib(nibName: "HistoryHeader", bundle: nil)
    view.collectionView.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: historyHeader)
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
