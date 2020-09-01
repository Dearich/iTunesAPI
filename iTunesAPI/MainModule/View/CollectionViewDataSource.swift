//
//  CollectionViewDataSource.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isSearching {
      return albums?.count ?? 0
    } else {
      return histiry.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let isEmpty = albums?.isEmpty, isEmpty {
      let historyId = "HistoryCell"
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: historyId,
                                                          for: indexPath) as? HistoryCollectionViewCell
        else { return UICollectionViewCell() }
      cell.artistLabel.text = histiry[indexPath.row]
      return cell

    } else {
      let mainId = "MainCell"
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainId,
                                                          for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }

      guard let album = albums?[indexPath.row] else { return cell }

      cell.presenter.album = album
      cell.presenter.setupCell()

      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {

    if (kind == UICollectionView.elementKindSectionHeader) {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)

      return headerView
    }
    return UICollectionReusableView()
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {

    if let isEmpty = albums?.isEmpty, isEmpty {
      return CGSize(width: collectionView.frame.width, height: 50.0)
    }
    return CGSize.zero
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    seachBar.searchBar.resignFirstResponder()
  }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    var height: CGFloat = 105
    if let isEmpty = albums?.isEmpty, isEmpty {
      height = 50
    }
    return CGSize(width: collectionView.bounds.width * 0.95, height: height)
  }
}
