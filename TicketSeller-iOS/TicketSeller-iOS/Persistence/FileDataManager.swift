//
//  FileDataManager.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 30/10/25.
//

import Foundation

struct FileDataManager {
  
  static var directory: URL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[0]
  }()
  
  // MARK: - Save

  static func save<T: Codable>(_ object: T, as fileName: String) throws {
    let fileURL = directory.appendingPathComponent(fileName)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let data = try encoder.encode(object)
    try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
  }

  // MARK: - Load

  static func load<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
    let fileURL = directory.appendingPathComponent(fileName)
    let data = try Data(contentsOf: fileURL)
    return try JSONDecoder().decode(T.self, from: data)
  }

  // MARK: - Update (Same as save)

  static func update<T: Codable>(_ object: T, as fileName: String) throws {
    try save(object, as: fileName)
  }

  // MARK: - Delete

  static func delete(fileName: String) throws {
    let fileURL = directory.appendingPathComponent(fileName)
    if FileManager.default.fileExists(atPath: fileURL.path) {
      try FileManager.default.removeItem(at: fileURL)
    }
  }

  // MARK: - Exists

  static func exists(fileName: String) -> Bool {
    let fileURL = directory.appendingPathComponent(fileName)
    return FileManager.default.fileExists(atPath: fileURL.path)
  }
}

//MARK: Keys

extension FileDataManager {
  static let accountKey: String = "AccountUser"

  static func showtimes(id: String) -> String {
    return "showtime_\(id).json"
  }
}
