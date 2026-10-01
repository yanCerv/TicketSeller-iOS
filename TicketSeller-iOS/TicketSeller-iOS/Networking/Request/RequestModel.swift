//
//  RequestModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

struct RequestModel: EndPoint {
  var path: String
  var method: Method
  var requestBody: Encodable?
  var queryItems: [URLQueryItem]?
  var provider: APIProvider
  var isAuthorized: Bool
  var cachePolicy: URLRequest.CachePolicy
  
  init(path: String, method: Method = .get, requestBody: Encodable? = nil, queryItems: [URLQueryItem]? = nil, provider: APIProvider, isAuthorized: Bool = true, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) {
    self.path = path
    self.method = method
    self.requestBody = requestBody
    self.queryItems = queryItems
    self.provider = provider
    self.isAuthorized = isAuthorized
    self.cachePolicy = cachePolicy
  }
}
