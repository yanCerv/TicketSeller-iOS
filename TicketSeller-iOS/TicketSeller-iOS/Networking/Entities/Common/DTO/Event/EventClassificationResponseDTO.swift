//
//  EventClassificationResponseDTO.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 11/11/25.
//

struct EventClassificationResponseDTO: Decodable {
  let embedded: EventClassification?
  let page: EventClassificationPage?
  
  enum CodingKeys: String, CodingKey {
    case embedded = "_embedded"
    case page
  }
}
