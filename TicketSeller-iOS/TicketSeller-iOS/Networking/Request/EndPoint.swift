//
//  EndPoint.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

enum APIProvider {
  case movieDB
  case ticketmaster
  
  private var env: Env {
    return Env()
  }

  var baseURL: String {
    switch self {
    case .movieDB:
      return env.get(.baseUrl)
    case .ticketmaster:
      return env.get(.ticketmasterUrl)
    }
  }

  var headers: [String: String] {
    switch self {
    case .movieDB:
      return [
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(Env().get(.bearerToken))"
      ]
    case .ticketmaster:
      return [
        "accept": "application/json"
      ]
    }
  }
}

protocol EndPoint {
  var path: String { get }
  var method: Method { get }
  var parameters: Encodable? { get }
  var queryItems: [URLQueryItem]? { get }
  var provider: APIProvider { get }
}

enum Method: String {
  case get = "GET"
  case post = "POST"
}

extension EndPoint {
  
  private var baseUrl: URL {
    var components = URLComponents(string: "\(provider.baseURL)\(path)")
    components?.queryItems = queryItems
    return components!.url!
  }
  
  private var headers: [String: String] {
    return provider.headers
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
