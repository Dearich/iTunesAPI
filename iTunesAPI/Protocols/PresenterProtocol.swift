//
//  PresenterProtocol.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
protocol PresenterProtocol: class {
  var view: ViewProtocol? { get }
  init(view: ViewProtocol)
  func getAlbums(_ searchText: String, complition: @escaping ([Album]) -> Void)
  func setupCollectionView()
}