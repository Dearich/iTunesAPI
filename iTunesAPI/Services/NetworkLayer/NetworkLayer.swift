//
//  NetworkLayer.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class NetworkLayer {
  static let shared = NetworkLayer()
  
  // MARK: - API Calls
  
  func getAlbums(_ query: String, completion: @escaping ( Result<Artist, Error>) -> Void) {
    
    // setup URL
    guard var components = URLComponents(string: "https://itunes.apple.com/search") else { return }
    components.queryItems = [URLQueryItem(name: "term", value: "\(query)"),
                             URLQueryItem(name: "entity", value: "album")]
//                             URLQueryItem(name: "country", value: "RU")]
    let url = components.url!
    print("GET: \(url.absoluteString)")
    
    // setup API call
    let task = URLSession.shared.dataTask(with: url) {[weak self] (data, _, error) in
      guard let self = self else { return }
      if let data = data {
        print(data)
        let jsonDecoder = JSONDecoder()
        do {
          let artist = try jsonDecoder.decode(Artist.self, from: data)
          NotificationCenter.default.addObserver(self, selector: #selector(self.downloadImageWithNotification(_:)),
                                                 name: NSNotification.Name(rawValue: "DownloadImage"),
                                                 object: nil)
          completion(.success(artist))
        } catch let error2 {
          print("JSON parsing error: \(error2.localizedDescription)")
          completion(.failure(error2))
        }
      } else {
        print("API error: \(error!.localizedDescription)")
        completion(.failure(error!))
      }
    }
    task.resume()
  }
  
  @objc func downloadImageWithNotification(_ notificaion: NSNotification) {
    
    guard let userInfo = notificaion.userInfo,
      let imageView = userInfo["imageView"] as? UIImageView,
      let imageUrlStirng = userInfo["imageUrl"] as? String,
      let url = URL(string: imageUrlStirng)
      else { return }
    
    ImageService.getImageFromCashe(withURL: url) { (image, error) in
      if let image = image {
        DispatchQueue.main.async {
          imageView.image = image
        }
      } else if let error = error {
        print(error.localizedDescription)
      }
    }
  }
}
