//
//  MainViewController.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ViewProtocol {

  @IBOutlet weak var collectionView: UICollectionView!

  let seachBar = UISearchController(searchResultsController: nil)
  var albums: [Album]? {
    didSet {
      collectionView.reloadData()
    }
  }
  var histiry = [String]()

  var isSearchBarEmpty: Bool {
    return seachBar.searchBar.text?.isEmpty ?? true
  }

  var isSearching: Bool {
    return seachBar.isActive && !isSearchBarEmpty
  }
  var presenter: PresenterProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Search"
    presenter?.setupCollectionView()
    seachBar.searchResultsUpdater = self
    seachBar.obscuresBackgroundDuringPresentation = false
    seachBar.searchBar.placeholder = "Artists"
    navigationItem.searchController = seachBar
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
    seachBar.searchBar.delegate = self
    
  }
}

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    guard let request = searchBar.text else { return }
    presenter?.getAlbums(request, complition: { [weak self] (albums) in
      self?.albums = albums
      self?.histiry.append(request)
    })
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    albums?.removeAll()
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    albums?.removeAll()
  }
}
