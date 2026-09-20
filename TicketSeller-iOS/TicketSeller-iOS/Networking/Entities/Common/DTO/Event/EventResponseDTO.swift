//
//  EventResponseDTO.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import Foundation

struct EventsResponseDTO: Decodable {
  let embedded: EmbeddedEvents
  
  enum CodingKeys: String, CodingKey {
    case embedded = "_embedded"
  }
}
