//
//  UserProfile.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

struct UserProfile: Codable, Hashable {
  let firstName: String
  let lastName: String
  let email: String
  let language: String
  let countryCode: String
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case email = "email"
    case language = "language"
    case countryCode = "country_code"
  }
  
  static func emptyValues() -> UserProfile {
    UserProfile(firstName: "", lastName: "", email: "", language: "", countryCode: " ")
  }
}
