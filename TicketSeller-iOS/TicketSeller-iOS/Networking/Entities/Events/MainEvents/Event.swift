//
//  Event.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import Foundation

struct EmbeddedEvents: Decodable {
  let events: [Event]
}

struct Event: Decodable, Hashable {
  let id: String
  let name: String
  let url: String?
  let dates: EventDate
  let images: [EventImage]
  let embedded: EmbeddedVenues?
  
  var imageUrl: URL? {
    return URL(string: preferredImageString)
  }
  
  private var preferredImageString: String {
    if let stringUrl = getStringUrl(content: "RETINA_LANDSCAPE_16_9") {
      return stringUrl
    }
    
    if let stringUrl = getStringUrl(content: "TABLET_LANDSCAPE_LARGE_16_9") {
      return stringUrl
    }
    
    if let stringUrl = getStringUrl(content: "EVENT_DETAIL_PAGE_16_9") {
      return stringUrl
    }
    return ""
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case url
    case dates
    case images
    case embedded = "_embedded"
  }
  
  private func getStringUrl(content: String) -> String? {
    return images.first(where: { $0.url.contains(content) })?.url
  }
}
