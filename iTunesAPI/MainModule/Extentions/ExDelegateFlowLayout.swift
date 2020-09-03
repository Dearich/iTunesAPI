//
//  Ex.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

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

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {

    if isSearchBarEmpty && !history.isEmpty {
      return CGSize(width: collectionView.frame.width, height: 50.0)
    }
      return CGSize.zero
  }
}
