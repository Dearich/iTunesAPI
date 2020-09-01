//
//  MainCollectionViewCell.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

  var presenter: MainCellPresenter!

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var albumNameLabel: UILabel!
  @IBOutlet weak var songsCounterLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var view: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 5
    presenter = MainCellPresenter(view: self)
//   

  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }

  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else { return }

    let y = bounds.maxY - 0.5
    let minX = bounds.minX + 8
    let maxX = bounds.maxX

    context.setStrokeColor(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1).cgColor)
    context.setLineWidth(2.0)
    context.move(to: CGPoint(x: minX, y: y))
    context.addLine(to: CGPoint(x: maxX, y: y))
    context.strokePath()
  }
}
