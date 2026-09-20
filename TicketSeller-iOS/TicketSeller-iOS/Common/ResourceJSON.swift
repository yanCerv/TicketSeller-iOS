//
//  ResourceJSON.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 14/10/25.
//

import Foundation

final class ResourceJSON {
  static func from<T: Decodable>(fileName: String, type: T.Type) -> T {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
      fatalError("❌ Not found \(fileName).json in bundle.")
    }
    
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    } catch {
      fatalError("❌ Error decoding - \(fileName).json: \(error)")
    }
  }
}
