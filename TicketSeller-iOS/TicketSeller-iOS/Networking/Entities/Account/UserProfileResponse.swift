//
//  UserProfileResponse.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

struct UserProfileResponse: Codable, Hashable {
  let firstName: String?
  let lastName: String?
  let avatarUrl: String?
  let locale: String?
  
  static func emptyValues() -> UserProfileResponse {
    UserProfileResponse(firstName: "", lastName: "", avatarUrl: "", locale: "")
  }
}
