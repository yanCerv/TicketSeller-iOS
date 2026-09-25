//
//  AccessLoginResponse.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 23/09/26.
//

import Foundation

struct AccessLoginResponse: Decodable {
  let accessToken: String
  let refreshToken: String
  let tokenType: String
  let expiresIn: Int
  let accessTokenExpiresAt: String
  let session: UserSession
  
  static func emptyValues() -> AccessLoginResponse {
    return AccessLoginResponse(accessToken: "", refreshToken: "", tokenType: "", expiresIn: 0, accessTokenExpiresAt: "", session: .emptyValues())
  }
}

struct UserSession: Decodable {
  let expiresAt: String
  let timeZone: String
  
  static func emptyValues() -> UserSession {
    return UserSession(expiresAt: "", timeZone: "")
  }
}
