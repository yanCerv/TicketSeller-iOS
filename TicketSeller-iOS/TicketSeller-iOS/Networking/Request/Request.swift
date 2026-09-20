//
//  Request.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation
import Combine

typealias PublisherResult<T: Decodable> = AnyPublisher<T, ErrorHandler>


protocol Request {
  func request<T: Decodable>(with model: RequestModel) -> PublisherResult<T>
  func request<T: Decodable>(with model: RequestModel) async throws -> T
}

extension Request {
  
  private var requestHolder: URLSession {
    let sessionDelegate = ClientURLSession()
    return URLSession(configuration: .default, delegate: sessionDelegate, delegateQueue: .main)
  }
  
  func request<T: Decodable>(with model: RequestModel) -> PublisherResult<T> {
    let urlResquest = model.request
    return requestHolder.dataTaskPublisher(for: urlResquest)
      .tryMap { element -> Data in
        if let response = element.response as? HTTPURLResponse {
          switch response.statusCode {
          case 200...299:
            return element.data
          default:
            if let error = element.response as? Error {
              throw ErrorHandler.error(message: error.localizedDescription, statusCode: response.statusCode)
            } else {
              throw ErrorHandler.error(message: "Error", statusCode: response.statusCode)
            }
          }
        }
        return element.data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error in
        return .jsonConversionFail(message: error.localizedDescription)
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  //New
  func request<T: Decodable>(with model: RequestModel) async throws -> T {
    let modelRequest = model.request
    let (data, response) = try await self.requestHolder.data(for: modelRequest)
    
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
