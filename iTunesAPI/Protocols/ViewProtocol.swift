//
//  ViewProtocol.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
protocol ViewProtocol: class {
  var presenter: PresenterProtocol? { get }
  var seachBar: UISearchController { get }
}
