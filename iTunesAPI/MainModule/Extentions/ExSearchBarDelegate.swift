//
//  Ex.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    guard let request = searchBar.text else { return }
    presenter?.getAlbums(request, completion: { [weak self] (albums) in
      self?.albums = albums
      CoreDataService.shared.save(recents: request)
    })
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    albums?.removeAll()
    history = CoreDataService.shared.fetch()
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    albums?.removeAll()
    history = CoreDataService.shared.fetch()
  }
}
