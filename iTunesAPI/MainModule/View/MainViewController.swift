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
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var loadingLabel: UILabel!
  
  let seachBar = UISearchController(searchResultsController: nil)
  var albums: [Album]? {
    didSet {
      collectionView.reloadData()
    }
  }
  var history = [Recent]()
  
  var isSearchBarEmpty: Bool {
    return seachBar.searchBar.text?.isEmpty ?? true
  }
  
  var presenter: PresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Search"
    spinner.isHidden = true
    loadingLabel.isHidden = true
    presenter?.setupCollectionView()
    setupRecent()
    seachBar.searchResultsUpdater = self
    seachBar.obscuresBackgroundDuringPresentation = false
    seachBar.searchBar.placeholder = "Artists, albums"
    navigationItem.searchController = seachBar
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
    seachBar.searchBar.delegate = self
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func setupRecent() {
    if CoreDataService.shared.entityIsEmpty() {
      history = [Recent]()
    } else {
      history = CoreDataService.shared.fetch()
    }
  }
}
