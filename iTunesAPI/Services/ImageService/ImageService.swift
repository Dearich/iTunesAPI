//
//  ImageService.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
class ImageService {
  static let cashe = NSCache<NSString, UIImage>()
  
  static func dowloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?, Error?) -> Void ) {
    let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
      var dowloadedImage:UIImage?
      if let error = error {
        print(error.localizedDescription)
        completion(nil, error)
      }
      guard let data = data else { return }
      dowloadedImage = UIImage(data: data)
      
      if dowloadedImage != nil {
        //Cashing image
        cashe.setObject(dowloadedImage!, forKey: url.absoluteString as NSString)
      }
      DispatchQueue.main.async {
        completion(dowloadedImage, nil)
      }
      
    }
    dataTask.resume()
  }
  
  static func getImageFromCashe(withURL url: URL, completion: @escaping (_ image: UIImage?, Error?) -> Void ) {
    if let image = cashe.object(forKey: url.absoluteString as NSString) {
      completion(image, nil)
    } else {
      dowloadImage(withURL: url, completion: completion)
    }
  }
  
}
