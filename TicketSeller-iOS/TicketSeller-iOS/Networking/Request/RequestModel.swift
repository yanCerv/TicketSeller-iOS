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
  var parameters: Encodable?
  var queryItems: [URLQueryItem]?
  var provider: APIProvider

  init(path: String, method: Method = .get, parameters: Encodable? = nil, queryItems: [URLQueryItem]? = nil, provider: APIProvider = .movieDB) {
    self.path = path
    self.method = method
    self.parameters = parameters
    self.queryItems = queryItems
    self.provider = provider
  }
}
