//
//  Classification.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 11/11/25.
//

struct SegmentDetail: Decodable, Hashable {
  let id: String
  let name: String
  let embedded: EventGenreDetail?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case embedded = "_embedded"
  }
}
