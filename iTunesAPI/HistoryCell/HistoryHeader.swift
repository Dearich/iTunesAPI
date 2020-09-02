//
//  HistoryHeader.swift
//  iTunesAPI
//
//  Created by Азизбек on 02.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol HistoryHeaderProtocol: class {
  func clearHistory()
}

class HistoryHeader: UICollectionReusableView {

  weak var historyHeaderDelegate: HistoryHeaderProtocol?
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}
