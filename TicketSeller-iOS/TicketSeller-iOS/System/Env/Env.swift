//
//  Environment.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import SwiftUI

final class Env {
    
  public private(set) var fileConfig: String!
  public private(set) var fileContent: NSDictionary!
  public private(set) var environmentType: EnvironmentType!
  public private(set) var attributes: [String: String] = [:]
  
  //MARK: Init
  
  init() {
    setupEnvironment()
  }
  
  //MARK: Methods
  
  func get(_ value: EnvironmentValue) -> String {
    if let value = attributes[value.rawValue] {
      return value
    }
    return ""
  }
  
  //MARK: Private Methods
  
  private func setupEnvironment() {
    let env = getKeyEnv()
    environmentType = env
    fileConfig = Bundle.main.path(forResource: "Env", ofType: "plist")
    fileContent = NSDictionary(contentsOfFile: fileConfig)
    if let atributes = fileContent[env.rawValue] as? [String: String] {
      self.attributes = atributes
    }
  }
  
  // MARK: Private Methods
  
  private func getKeyEnv() -> EnvironmentType {
     #if Production
    return .production
     #else
    return .development
     #endif
  }
  
  enum EnvironmentValue: String {
    case baseUrl
    case bearerToken
    case ticketmasterUrl
    case ticketmasterKey
  }
  
  enum EnvironmentType: String {
    case development
    case production
  }
}
