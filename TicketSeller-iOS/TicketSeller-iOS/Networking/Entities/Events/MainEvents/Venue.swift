//
//  Venue.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

struct EmbeddedVenues: Decodable, Hashable {
  let venues: [Venue]
}

struct Venue: Decodable, Hashable {
  let name: String?
  let city: City?
  let country: TicketMasterCountry?
}
