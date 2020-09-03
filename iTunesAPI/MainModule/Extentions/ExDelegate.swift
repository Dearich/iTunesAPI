//
//  ExDelegate.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    if let cell = collectionView.cellForItem(at: indexPath) as? HistoryCollectionViewCell {
      presenter?.historyCellTapped(cell: cell, text: history[indexPath.row])
    } else if let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell{
      let detailView = ModuleBuilder.createDetail()
      detailView.presenter?.album = albums?[indexPath.row]
      detailView.presenter?.image = cell.imageView.image
      navigationController?.pushViewController(detailView, animated: true)
    }
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    seachBar.searchBar.resignFirstResponder()
  }
}
