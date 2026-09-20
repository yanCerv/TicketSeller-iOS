//
//  EventSubGenre.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 11/11/25.
//

struct EventSubGenre: Decodable, Hashable {
  let subgenres: [SubGenre]
}

struct SubGenre: Codable, Hashable {
  let id: String
  let name: String
}
