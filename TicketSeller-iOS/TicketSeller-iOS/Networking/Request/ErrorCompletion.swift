//
//  ErrorCompletion.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Combine

protocol ErrorCompletion {
  func error(_ subscriber: Subscribers.Completion<ErrorHandler>) -> ErrorHandler?
}

extension ErrorCompletion {
  func error(_ subscriber: Subscribers.Completion<ErrorHandler>) -> ErrorHandler? {
    var errorHandler: ErrorHandler?
    switch subscriber {
    case .failure(let error):
      errorHandler = ErrorHandler.error(message: error.message, statusCode: error.statusCode)
      return errorHandler
    case .finished:
      return errorHandler
    }
  }
}
