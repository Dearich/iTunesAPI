//
//  MainPresenter.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
class MainPresenter: PresenterProtocol {
  weak var view: ViewProtocol?

  required init(view: ViewProtocol) {
    self.view = view
  }

}
