//
//  CollectionViewDataSource.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     if !isSearchBarEmpty {
       return albums?.count ?? history.count
     } else {
       return history.count
     }
   }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let isEmpty = albums?.isEmpty, isEmpty {
      let historyId = "HistoryCell"
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: historyId,
                                                          for: indexPath) as? HistoryCollectionViewCell
        else { return UICollectionViewCell() }
      cell.artistLabel.text = history[indexPath.row]
      return cell

    } else {
      let mainId = "MainCell"
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainId,
                                                          for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }

      guard let album = albums?[indexPath.row] else { return cell }
      cell.presenter.album = album
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {

    if (kind == UICollectionView.elementKindSectionHeader) {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "Header",
                                                                       for: indexPath)

      let clearBuuton = UIButton()
      clearBuuton.setTitle("Clear", for: .normal)
      headerView.addSubview(clearBuuton)
      clearBuuton.translatesAutoresizingMaskIntoConstraints = false
      clearBuuton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
      clearBuuton.rightAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
      clearBuuton.setTitleColor(#colorLiteral(red: 1, green: 0.2327715456, blue: 0.1867191494, alpha: 1), for: .normal)
      clearBuuton.titleLabel?.font = .boldSystemFont(ofSize: 19)
      clearBuuton.addTarget(self, action: #selector(clearHistory), for: .touchUpInside)
      return headerView
    }
    return UICollectionReusableView()
  }

  @objc func clearHistory() {
    //TODO Core Data remove all
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let alertAction = UIAlertAction(title: "Clear Recent Searches", style: .destructive) { [weak self] (_) in
      self?.history.removeAll()
      self?.collectionView.reloadData()
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

    alert.addAction(cancel)
    alert.addAction(alertAction)
    alert.view.tintColor = UIColor.red
    present(alert,animated: true)
  }
}
