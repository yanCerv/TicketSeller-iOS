//
//  Purchase.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 24/10/25.
//

struct BookingInfo: Decodable, Hashable {
  let bookingInfo: Purchase
}

struct Purchase: Decodable, Hashable {
  let bookingId: String
  let bookingNumber: String
  let transactionNUMber: String
  
  enum CodingKeys: String, CodingKey {
    case bookingId = "booking_id"
    case bookingNumber = "booking_number"
    case transactionNUMber = "transaction_number"
  }
}
