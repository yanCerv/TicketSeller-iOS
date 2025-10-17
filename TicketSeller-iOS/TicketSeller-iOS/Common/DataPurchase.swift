//
//  DataPurchase.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

struct DataPurchase {
  let movieDetail: MovieDetail
  let showtime: Showtime
  let seatQuantitySelected: Int
  let sessionData: SessionData?
  
  init(movieDetail: MovieDetail, showtime: Showtime, sessionData: SessionData? = nil, seatQuantitySelected: Int) {
    self.movieDetail = movieDetail
    self.showtime = showtime
    self.sessionData = sessionData
    self.seatQuantitySelected = seatQuantitySelected
  }
}

struct SessionData {
  let sessionId: String
  let orderId: String
  let date: Date
}
