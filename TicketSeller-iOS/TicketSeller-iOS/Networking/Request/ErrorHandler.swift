//
//  ErrorHandler.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Combine

enum ErrorHandler: Error {
  case requestFail
  case error(message: String, statusCode: Int)
  case jsonConversionFail(message: String)
  case connection
  
  var statusCode: Int {
    switch self {
    case .requestFail:
      return 500
    case .error(_, let statusCode):
      return statusCode
    case .jsonConversionFail(_):
      return -1001
    case .connection:
      return 550
    }
  }
  
  var message: String {
    switch self {
    case .requestFail:
      return "Error server connection."
    case .jsonConversionFail(let message):
      return "Error: \(message)"
    case .error(let message, _):
      return "\(message)"
    case .connection:
      return "No internet connection."
    }
  }
}
