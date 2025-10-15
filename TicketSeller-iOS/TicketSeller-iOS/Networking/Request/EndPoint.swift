//
//  EndPoint.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

protocol EndPoint {
  var path: String { get }
  var method: Method { get }
  var parameters: Encodable? { get }
  var queryItems: [URLQueryItem]? { get }
}

enum Method: String {
  case get = "GET"
  case post = "POST"
}

extension EndPoint {
  
  private var environment: Env {
    return Env()
  }
  
  private var baseUrl: URL {
    let baseUrl = environment.get(.baseUrl)
    var components = URLComponents(string: "\(baseUrl)\(path)")
    components?.queryItems = queryItems
    return components!.url!
  }
  
  private var headers: [String: String] {
    let headers: [String: String] = [
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer \(environment.get(.bearerToken))"
    ]
    return headers
  }
  
  private var data: Data? {
    return nil // TODO
  }
  
  var request: URLRequest {
    var request = URLRequest(url: baseUrl)
    request.allHTTPHeaderFields = headers
    request.httpMethod = method.rawValue
    request.httpBody = method.rawValue == "GET" ? nil : data
    request.timeoutInterval = 300
    debugPrint("Request: \(baseUrl)")
    return request
  }
}
