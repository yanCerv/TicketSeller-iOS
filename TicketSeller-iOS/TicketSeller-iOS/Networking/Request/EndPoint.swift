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

  var baseURL: String {
    switch self {
    case .movieDB:
      return NetworkEnvironment.shared.environment.get(.baseUrl)
    case .ticketmaster:
      return NetworkEnvironment.shared.environment.get(.ticketmasterUrl)
    }
  }

  var headers: [String: String] {
    switch self {
    case .movieDB:
      return [
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(NetworkEnvironment.shared.environment.get(.bearerToken))"
      ]
    case .ticketmaster:
      return [
        "accept": "application/json"
      ]
    }
  }
  
  func queriItems(countryCode: String = "") -> [URLQueryItem] {
    switch self {
    case .movieDB:
      return [URLQueryItem(name: "language", value: "es-MX"), URLQueryItem(name: "page", value: "1")]
    case .ticketmaster:
      return [URLQueryItem(name: "countryCode", value: "MX"),
              URLQueryItem(name: "size", value: "10"),
              URLQueryItem(name: "apikey", value: NetworkEnvironment.shared.environment.get(.ticketmasterKey))]
    }
  }
}

protocol EndPoint {
  var path: String { get }
  var method: Method { get }
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
    components?.queryItems = provider.queriItems()
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

final class NetworkEnvironment {
  static let shared = NetworkEnvironment()
  
  let environment: Env
  
  private init() {
    self.environment = Env()
  }
}
