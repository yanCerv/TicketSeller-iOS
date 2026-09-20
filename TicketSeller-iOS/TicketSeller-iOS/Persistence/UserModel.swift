//
//  UserModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 28/10/25.
//

import Foundation
import SwiftData

@Model
final class UserModel {
  @Attribute(.unique) var email: String
  var fullName: String
  var password: String
  var createdAt: Date

  init(email: String, fullName: String, password: String) {
    self.email = email
    self.fullName = fullName
    self.password = password
    self.createdAt = .now
  }
}
