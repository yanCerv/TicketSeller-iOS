//
//  AuthMode.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

enum AuthMode: CaseIterable, Hashable {
  case login
  case register
      
  var title: String {
    switch self {
    case .login:
      return "Log In" // TODO Localize
    case .register:
      return "Register" // TODO localize
    }
  }
}
