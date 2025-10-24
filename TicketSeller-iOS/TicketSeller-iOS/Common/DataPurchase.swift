//
//  DataPurchase.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

struct DataPurchase: Hashable {
  let movieDetail: MovieDetail
  let showtime: Showtime
  let seatQuantitySelected: Int
  
  let sessionData: SessionData?
  var purchase: Purchase?
  
  var selectedSeats: [Seat] = []
  
  var totalPrice: Double {
    selectedSeats.reduce(0) { $0 + $1.price }
  }
  
  init(movieDetail: MovieDetail, showtime: Showtime, sessionData: SessionData? = nil, seatQuantitySelected: Int) {
    self.movieDetail = movieDetail
    self.showtime = showtime
    self.sessionData = sessionData
    self.seatQuantitySelected = seatQuantitySelected
  }
}

struct SessionData: Hashable {
  let sessionId: String
  let orderId: String
  let date: Date
}
