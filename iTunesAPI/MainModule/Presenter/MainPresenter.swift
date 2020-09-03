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
    guard let mainView = view as? MainViewController else { return }
    mainView.spinner.isHidden = false
    mainView.spinner.startAnimating()
    mainView.loadingLabel.isHidden = false
    let backgroundQueue = DispatchQueue(label: "ru.azizbek.fetchAlbum", qos: .userInitiated, attributes: .concurrent)
    backgroundQueue.async {
      NetworkLayer.shared.getAlbums(searchText.lowercased()) { [weak self] (result) in
        DispatchQueue.main.async {
          switch result {

          case .success(let artist):
            if artist.albums.isEmpty {
              self?.setAlert(title: "Empty response", message: "try to find something else")
            } else {
              complition(artist.albums)
            }
          case .failure(let error):
            print(error.localizedDescription)
            self?.setAlert(title: "Error", message: error.localizedDescription)
          }
          mainView.spinner.isHidden = true
          mainView.spinner.stopAnimating()
          mainView.loadingLabel.isHidden = true

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
  func historyCellTapped(cell: UICollectionViewCell, text: String) {
    UIView.animate(withDuration: 0.5) {
           cell.contentView.backgroundColor = .systemGray6
           cell.contentView.backgroundColor = .clear
         }
    view?.seachBar.becomeFirstResponder()
    view?.seachBar.searchBar.searchTextField.becomeFirstResponder()
    view?.seachBar.searchBar.searchTextField.text = text
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
