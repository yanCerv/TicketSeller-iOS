//
//  RequestModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

nonisolated struct RequestModel: EndPoint, Sendable {
  var path: String
  var method: Method
  var queryItems: [URLQueryItem]?
  var provider: APIProvider

  init(path: String, method: Method = .get, queryItems: [URLQueryItem]? = nil, provider: APIProvider = .movieDB) {
    self.path = path
    self.method = method
    self.queryItems = queryItems
    self.provider = provider
  }
}
