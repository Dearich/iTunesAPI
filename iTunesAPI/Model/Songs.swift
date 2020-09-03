//
//  SongsModel.swift
//  iTunesAPI
//
//  Created by Азизбек on 03.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

// MARK: - Result
class Song {

  var artistName: String?
  var primaryGenreName: String?
  var trackName: String?
  var previewURL: String?
  var trackTimeMillis: Int?

//  enum CodingKeys: String, CodingKey {
//    case wrapperType
//    case artistID = "artistId"
//    case collectionID = "collectionId"
//    case artistName, collectionName
//    case collectionViewURL = "collectionViewUrl"
//    case collectionPrice, country, currency, primaryGenreName
//    case trackName
//    case previewURL = "previewUrl"
//    case trackTimeMillis
//  }

//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    wrapperType = try container.decode(String.self, forKey: .wrapperType)
//    artistID = try container.decode(Int.self, forKey: .artistID)
//    collectionID = try container.decode(Int.self, forKey: .collectionID)
//    artistName = try container.decode(String.self, forKey: .artistName)
//    collectionName = try container.decode(String.self, forKey: .collectionName)
//    collectionPrice = try container.decode(Double.self, forKey: .collectionPrice)
//    country = try container.decode(String.self, forKey: .country)
//    currency = try container.decode(String.self, forKey: .currency)
//    primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
//    trackName = try container.decode(String.self, forKey: .trackName)
//    previewURL = try container.decode(String.self, forKey: .previewURL)
//    trackTimeMillis = try container.decode(Int.self, forKey: .trackTimeMillis)
//  }
}
