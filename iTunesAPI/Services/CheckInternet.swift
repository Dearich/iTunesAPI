//
//  CheckInternet.swift
//  iTunesAPI
//
//  Created by Азизбек on 02.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Network

protocol NetworkConnectionProtocol {
  func checkInternetConnection(completion: @escaping (Bool) -> Void)
}

final class CheckInternet: NetworkConnectionProtocol {
  
  static let shared = CheckInternet()
  
  func checkInternetConnection(completion: @escaping (Bool) -> Void) {
    let monitor = NWPathMonitor()
    monitor.pathUpdateHandler = { path in
      DispatchQueue.main.async {
        if path.status == .satisfied {
          completion(true)
        } else {
          completion(false)
        }
      }
    }
    let queue = DispatchQueue(label: "Network")
    monitor.start(queue: queue)
  }
}
