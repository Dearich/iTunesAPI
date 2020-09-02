//
//  Album.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

struct Album: Decodable {
  let artist: String?
  let albumName: String?
  let albumId: Int?
  let imageUrl: String?
  let trackCount: Int?
  let releaseDate: String?
  
  private enum CodingKeys: String, CodingKey {
    case artist = "artistName"
    case albumName = "collectionName"
    case albumId = "collectionId"
    case imageUrl = "artworkUrl100"
    case trackCount
    case releaseDate
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    artist = try container.decode(String.self, forKey: .artist)
    albumName = try container.decode(String.self, forKey: .albumName)
    albumId = try container.decode(Int.self, forKey: .albumId)
    imageUrl = try container.decode(String.self, forKey: .imageUrl)
    trackCount = try container.decode(Int.self, forKey: .trackCount)
    releaseDate = try container.decode(String.self, forKey: .releaseDate)
  }
}
