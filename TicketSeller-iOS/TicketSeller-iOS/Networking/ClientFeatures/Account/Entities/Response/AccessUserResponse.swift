//
//  AccessUserResponse.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 23/09/26.
//

struct AccessUserResponse: Decodable {
  let id: String
  let email: String
  let isActive: Bool
  let createdAt: String
  let profile: UserProfileResponse?
  
  static func emptyValues() -> AccessUserResponse {
    return AccessUserResponse(id: "", email: "", isActive: false, createdAt: "", profile: nil)
  }
  
  func dataProfile() -> UserProfile? {
    if let profile {
      return UserProfile(id: id, name: profile.firstName ?? "", lastName: profile.lastName ?? "", email: email, avatarUrl: profile.avatarUrl, locale: profile.locale)
    }
    return nil
  }
}
