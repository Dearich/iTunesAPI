//
//  Ex.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension DetailViewController:UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.songs?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: celIdentifier, for: indexPath)
    cell.layoutMargins = UIEdgeInsets.zero
    let number = indexPath.row + 1
    let fullCellText = "\(number)  \(presenter?.songs?[indexPath.row].trackName ?? "nil")"
    let numberToColor = "\(number)"
    let range = (fullCellText as NSString).range(of: numberToColor)
    let coloredText = NSMutableAttributedString(string: fullCellText)
    coloredText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.systemGray3], range: range)

    cell.textLabel?.attributedText = coloredText
    
    return cell
  }
}
