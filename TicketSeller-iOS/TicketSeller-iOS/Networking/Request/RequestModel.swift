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
}
