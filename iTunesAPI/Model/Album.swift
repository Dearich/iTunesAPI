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
  let artistImageUrl: String?
  let trackCount: Int?

 private enum CodingKeys: String, CodingKey {
    case artist = "artistName"
    case albumName = "collectionName"
    case albumId = "collectionId"
    case artistImageUrl = "collectionViewUrl"
    case trackCount
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    artist = try container.decode(String.self, forKey: .artist)
    albumName = try container.decode(String.self, forKey: .albumName)
    albumId = try container.decode(Int.self, forKey: .albumId)
    artistImageUrl = try container.decode(String.self, forKey: .artistImageUrl)
    trackCount = try container.decode(Int.self, forKey: .trackCount)
  }
}
