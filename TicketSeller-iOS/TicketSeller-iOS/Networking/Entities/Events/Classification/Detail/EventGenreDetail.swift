//
//  EventGenreDetail.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 11/11/25.
//

struct EventGenreDetail: Decodable, Hashable {
  let genres: [GenreDetail]
}

struct GenreDetail: Decodable, Hashable {
  let id: String
  let name: String
  let embedded: EventSubGenre?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case embedded = "_embedded"
  }
}
