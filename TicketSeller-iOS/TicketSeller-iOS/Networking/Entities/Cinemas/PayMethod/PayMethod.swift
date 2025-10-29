//
//  PayMethod.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

import Foundation

struct PayMethod: Decodable, Hashable {
  let id: String
  let title: String
  let iconUrl: String
  let webUrl: String
  let isActive: Bool
  
  var iconURL: URL? {
    return URL(string: iconUrl)
  }
  
  var paymentUrl: URL? {
    return URL(string: webUrl)
  }
  
  var imageName: String {
    switch id {
    case "paypal":
      return "paypal"
    case "apple-pay":
      return "apple-pay"
    default:
      return "cardpaymethods"
    }
  }
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case iconUrl = "iconURL"
    case webUrl = "webURL"
    case isActive
  }
}
