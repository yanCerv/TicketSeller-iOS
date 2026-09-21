//
//  Request.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

protocol Request {
  func request<T: Decodable>(with model: RequestModel) async throws -> T
}

fileprivate enum NetworkSession {
  static let shared: URLSession = {
    URLSession(configuration: .default, delegate: ClientURLSession(), delegateQueue: .main)
  }()
}

extension Request {
  
  //New
  func request<T: Decodable>(with model: RequestModel) async throws -> T {
    let modelRequest = model.request
    let (data, response) = try await NetworkSession.shared.data(for: modelRequest)
    
    guard let result = response as? HTTPURLResponse else {
      throw ErrorHandler.requestFail
    }
    
    switch result.statusCode {
    case 200...299:
      let decode = try JSONDecoder().decode(T.self, from: data)
      return decode
    default:
      if let error = response as? Error {
        throw ErrorHandler.error(message: error.localizedDescription, statusCode:  result.statusCode)
      }
      throw ErrorHandler.requestFail
    }
  }
}
