//
//  EndPoint.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation
import Security

enum APIProvider {
  case host
  
  var baseURL: String {
    switch self {
    case .host:
      return NetworkEnvironment.shared.environment.get(.hostUrl)
    }
  }

  func headers(isAuthorized: Bool) -> [String: String] {
    switch self {
    case .host:
      let keyChainStore = KeychainStore()
      var headers = ["accept": "application/json",
                     "Content-Type": "application/json"]
      let isExpired = Date.isAccessOrSessionExpired(using: FileDataManager.accessExpired)
      
      if let token = try? keyChainStore.value(for: .access),
       !isExpired && isAuthorized {
        headers["Authorization"] = "Bearer \(token)"
        return headers
      }
      return headers
    }
  }
  
}

protocol EndPoint {
  var path: String { get }
  var method: Method { get }
  var requestBody: Encodable? { get }
  var queryItems: [URLQueryItem]? { get }
  var provider: APIProvider { get }
  var isAuthorized: Bool { get }
}

enum Method: String {
  case get = "GET"
  case post = "POST"
}

extension EndPoint {
  
  private var baseUrl: URL {
    var components = URLComponents(string: "\(provider.baseURL)\(path)")
    if let queryItems, !queryItems.isEmpty {
      components?.queryItems = queryItems
    }
    return components!.url!
  }
  
  private var headers: [String: String] {
    return provider.headers(isAuthorized: isAuthorized)
  }
  
  private var data: Data? {
    if let requestBody {
      let data = try? JSONEncoder().encode(requestBody)
      return data
    }
    return nil
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
