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

  private let reuseIdentifier = "MainCell"
  let seachBar = UISearchController(searchResultsController: nil)
  var albums: [Album]? {
    didSet {
      collectionView.reloadData()
    }
  }
  var isSearchBarEmpty: Bool {
    return seachBar.searchBar.text?.isEmpty ?? true
  }
  var presenter: PresenterProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()
    albums = [Album]()
    let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    self.title = "Search"
    seachBar.searchResultsUpdater = self
    seachBar.obscuresBackgroundDuringPresentation = false
    seachBar.searchBar.placeholder = "Artists"
    navigationItem.searchController = seachBar
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
    
  }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return albums?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                        for: indexPath) as? MainCollectionViewCell
    else { return UICollectionViewCell() }

    return cell
  }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.bounds.width * 0.95, height: 105)
    }
}

extension MainViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
//TODO
  }
}
