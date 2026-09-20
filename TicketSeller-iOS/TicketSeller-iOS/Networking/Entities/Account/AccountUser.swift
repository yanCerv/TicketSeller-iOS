//
//  AccountUser.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

struct AccountUser: Codable, Hashable {
  let id: String
  let firstName: String
  let lastName: String
  let email: String
  let phone: String
  let language: String
  let countryCode: String
  let isVerified: Bool
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case firstName = "first_name"
    case lastName = "last_name"
    case email = "email"
    case phone = "phone"
    case language = "language"
    case countryCode = "country_code"
    case isVerified = "is_verified"
  }
}
