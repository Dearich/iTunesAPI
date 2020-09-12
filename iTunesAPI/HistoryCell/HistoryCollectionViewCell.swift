//
//  HistoryCollectionViewCell.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var artistLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    let y = view.bounds.minY
    let minX = view.bounds.minX
    let maxX = view.bounds.maxX
    
    context.setStrokeColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor)
    context.setLineWidth(2.0)
    context.move(to: CGPoint(x: minX, y: y))
    context.addLine(to: CGPoint(x: maxX, y: y))
    context.strokePath()
  }
  
}
