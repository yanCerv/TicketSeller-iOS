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
  
  static func emptyValues() -> AccessUserResponse {
    return AccessUserResponse(id: "", email: "", isActive: false, createdAt: "")
  }
}
