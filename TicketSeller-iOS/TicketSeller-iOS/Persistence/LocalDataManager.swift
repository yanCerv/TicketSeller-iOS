//
//  LocalDataManager.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

@MainActor
final class LocalDataManager {
  static let shared: LocalDataManager = LocalDataManager()
  
  private let manager: FileManager = FileManager.default
  
  //MARK: Methods
  
  func saveData<T: Encodable>(_ data: T, to file: String) {
    if !manager.fileExists(atPath: file),
       let fileUrl = component(file: file) {
      do {
        let dataEncode = try JSONEncoder().encode(data)
        try dataEncode.write(to: fileUrl)
      } catch {
        debugPrint("ERROR SAVING DATA IN: \(String(describing: self))")
      }
    }
  }
  
  func loadData<T: Decodable>(from file: String, type: T.Type) -> T? {
    if let fileUrl = component(file: file),
       manager.fileExists(atPath: fileUrl.path) {
      do {
        let data = try Data(contentsOf: fileUrl)
        let decodedData = try JSONDecoder().decode(type.self, from: data)
        return decodedData
      } catch {
        debugPrint("NO DATA IN: \(String(describing: self))")
      }
    }
    
    return nil
  }
  
  func updateData<T: Codable>(_ data: T, in file: String, type: T.Type) {
    if let _ = component(file: file) {
      if manager.fileExists(atPath: file) {
        deleteFile(at: file)
        debugPrint("Delete to update data")
      }
      
      saveData(data, to: file)
    }
  }
  
  func deleteFile(at file: String) {
    if let fileUrl = component(file: file) {
      if manager.fileExists(atPath: fileUrl.path) {
        do {
          try manager.removeItem(at: fileUrl)
        } catch {
          debugPrint("ERROR DELETING FILE IN: \(String(describing: self))")
        }
      }
    }
  }
  
  private func component(file: String) -> URL? {
    if let documentDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask).first {
      return documentDirectory.appending(path: file)
    }
    return nil
  }
}
