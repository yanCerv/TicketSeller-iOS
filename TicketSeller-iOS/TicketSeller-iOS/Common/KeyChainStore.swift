//
//  KeyChainStore.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 23/09/26.
//

import Foundation
import Security

enum KeyTypeStore: String {
  case access = "access-token"
  case refresh = "refresh-token"
  
  var key: String {
    return self.rawValue
  }
}

enum KeychainError: Error {
  case unexpectedStatus(OSStatus)
}

struct KeychainStore {
  private let service = "com.legionofhorses.mx.TicketSeller-iOS"
  
  func save(_ value: String, for account: KeyTypeStore) throws {
    let data = Data(value.utf8)
    
    let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrService as String: service,
                                kSecAttrAccount as String: account.key]
    
    let attributes: [String: Any] = [kSecValueData as String: data, kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly]
    
    let updateStatus = SecItemUpdate(
      query as CFDictionary,
      attributes as CFDictionary
    )
    
    if updateStatus == errSecItemNotFound {
      var addQuery = query
      attributes.forEach { addQuery[$0.key] = $0.value }
      
      let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
      guard addStatus == errSecSuccess else {
        throw KeychainError.unexpectedStatus(addStatus)
      }
      return
    }
    
    guard updateStatus == errSecSuccess else {
      throw KeychainError.unexpectedStatus(updateStatus)
    }
  }
  
  func value(for account: KeyTypeStore) throws -> String? {
    let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrService as String: service,
                                kSecAttrAccount as String: account.key,
                                kSecReturnData as String: true,
                                kSecMatchLimit as String: kSecMatchLimitOne]
    
    var result: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    if status == errSecItemNotFound {
      return nil
    }
    
    guard status == errSecSuccess,
          let data = result as? Data,
          let value = String(data: data, encoding: .utf8) else {
      throw KeychainError.unexpectedStatus(status)
    }
    
    return value
  }
  
  func deleteValue(for account: KeyTypeStore) throws {
    let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrService as String: service,
                                kSecAttrAccount as String: account.key]
    
    let status = SecItemDelete(query as CFDictionary)
    
    guard status == errSecSuccess || status == errSecItemNotFound else {
      throw KeychainError.unexpectedStatus(status)
    }
  }
}

extension KeychainStore {
  
  func getRefreshToken() -> String {
    if let refresh = try? value(for: .refresh) {
      return refresh
    }
    return ""
  }
  
  func isUserLogged() -> Bool {
    if let _ = try? value(for: .refresh) {
      return true
    }
    return false
  }
  
  func save(access: AccessLoginResponse) throws {
    try save(access.accessToken, for: .access)
    try save(access.refreshToken, for: .refresh)
    try FileDataManager.save(access.accessTokenExpiresAt, as: FileDataManager.accessExpired)
    try FileDataManager.save(access.session.expiresAt, as: FileDataManager.sessionExpired)
  }
  
  func deleteAccess() {
    do {
      try deleteValue(for: .access)
      try deleteValue(for: .refresh)
      try FileDataManager.delete(fileName: FileDataManager.accountKey)
      try FileDataManager.delete(fileName: FileDataManager.accessExpired)
      try FileDataManager.delete(fileName: FileDataManager.sessionExpired)
    } catch {
      debugPrint("Error \(error.localizedDescription)")
    }
  }
}
