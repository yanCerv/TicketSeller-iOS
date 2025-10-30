//
//  AppCountry.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

struct AppCountry: Codable, Hashable {
  let name: String
  let countryCode: String
  let languageCode: String
  let flag: String?
  
  var securedFlag: String {
    guard let flag else { return "" }
    return flag
  }
  
  private enum CodingKeys: String, CodingKey {
    case name
    case countryCode
    case languageCode
    case flag
  }
}
