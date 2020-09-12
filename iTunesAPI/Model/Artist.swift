//
//  Artist.swift
//  iTunesAPI
//
//  Created by Азизбек on 01.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
struct Artist: Decodable {
  let albums: [Album]
  enum CodingKeys:String, CodingKey {
    case albums = "results"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    albums = try container.decode([Album].self, forKey: .albums)
  }
}
