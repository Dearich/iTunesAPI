//
//  ModuleBuilder.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//
import UIKit

protocol Builder {
  static func createMain() -> UIViewController
}

class ModuleBuilder: Builder {
  static func createMain() -> UIViewController {
    let view = MainViewController()
    let presenter = MainPresenter(view: view)
    view.presenter = presenter
    return view
  }
}
