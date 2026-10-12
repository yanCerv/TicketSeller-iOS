//
//  PurchaseResponseModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 07/10/26.
//

nonisolated struct PurchaseResponseModel: Decodable, Hashable, Sendable {
  let id: String
  let bookingCode: String
  let status: String
  let purchasedAt: String
  let movie: Movie
  let showtime: Showtime
  let seats: [Seat]
  let payment: Payment
  let total: Double
  let currency: String
  
  nonisolated struct Movie: Decodable, Hashable, Sendable {
    let id: Int
    let title: String
    let posterPath: String?
    let durationMinutes: Int?
    let genres: [String]
  }
  
  nonisolated struct Showtime: Decodable, Hashable, Sendable {
    let startsAt: String
    let cinema: String
    let auditorium: String
    let screenType: String
  }
  
  nonisolated struct Seat: Decodable, Hashable, Sendable {
    let id: String
    let label: String
    let type: String
    let price: Double
  }
  
  nonisolated struct Payment: Decodable, Hashable, Sendable {
    let method: String
    let last4: String
    let status: String
  }
}
