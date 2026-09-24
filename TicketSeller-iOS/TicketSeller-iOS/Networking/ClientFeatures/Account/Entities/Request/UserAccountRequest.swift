//
//  UserAccountRequest.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 23/09/26.
//

nonisolated struct UserAccountRequest: Encodable {
  let email: String
  let password: String
}
