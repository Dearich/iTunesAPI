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
    components.queryItems = [URLQueryItem(name: "term", value: query),
                             URLQueryItem(name: "entity", value: "album")]
    let url = components.url!
    print("GET: \(url.absoluteString)")

    // setup API call
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let data = data {
        let jsonDecoder = JSONDecoder()
        do {
          let artist = try jsonDecoder.decode(Artist.self, from: data)
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
}
