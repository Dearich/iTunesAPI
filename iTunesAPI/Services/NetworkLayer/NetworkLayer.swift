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
  private let jsonDecoder = JSONDecoder()
  
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
        do {
          let artist = try self.jsonDecoder.decode(Artist.self, from: data)
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
  
  func getSongs(with id: Int, completion: @escaping (Result<[Song],Error>) -> Void) {
    guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&entity=song") else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      var songsResults = [Song]()
      if let data = data {
        do {
          guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
          if let jsonResults = json["results"] as? [AnyObject] {
            for item in jsonResults where item["wrapperType"] as? String == "track" {
              let song = Song()
              song.artistName = item["artistName"] as? String ?? "nil"
              song.previewURL = item["previewUrl"] as? String ?? "nil"
              song.primaryGenreName = item["primaryGenreName"] as? String ?? "nil"
              song.trackName = item["trackName"] as? String ?? "nil"
              song.trackTimeMillis = item["trackTimeMillis"] as? Int ?? 00
              songsResults.append(song)
            }
          }
          completion(.success(songsResults))
        } catch let error {
          print("JSON error:\(error.localizedDescription)")
          completion(.failure(error))
        }
      } else {
        print("error:\(String(describing: error?.localizedDescription))")
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
