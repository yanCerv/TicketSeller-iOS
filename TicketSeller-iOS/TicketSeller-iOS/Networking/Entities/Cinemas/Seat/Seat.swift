//
//  Seat.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 21/10/25.
//

import SwiftUI

struct SeatRow: Decodable, Hashable {
  let rowName: String
  var seats: [Seat]
}

// MARK: - Seat
struct Seat: Decodable, Hashable {
  let seatNumber: String
  let type: SeatType
  let status: String
  let price: Double
  let isAvailable: Bool?
  let position: Position
  
  var isSelected: Bool = false
  var rowSeat: String = ""
  
  /// Computed properties
  
  var seatWidth: CGFloat {
    if type == .sofa {
      return 70
    }
    return 40
  }
  
  var seatHeight: CGFloat {
    return 40
  }
  
  private enum CodingKeys: String, CodingKey {
    case seatNumber
    case type
    case status
    case price
    case isAvailable
    case position
  }
}

// MARK: - Position

struct Position: Codable, Hashable {
  let rowIndex: Int
  let columnIndex: Int
}

// MARK: - SeatType
enum SeatType: String, Decodable {
  case motion = "MOTION"
  case confort = "CONFORT"
  case premium = "PREMIUM"
  case sofa = "SOFA"
  case relax = "RELAX"
  case space = "SPACE"
}
