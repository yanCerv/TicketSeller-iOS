//
//  SeatSelectionViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

@Observable
final class SeatSelectionViewModel {
  
  let dataPurchase: DataPurchase
  var movieDetail: MovieDetail!
  var showtime: Showtime!
  
  init(movieDetail: MovieDetail, showtime: Showtime, seatQuantitySelected: Int) {
    self.movieDetail = movieDetail
    self.showtime = showtime
    dataPurchase = DataPurchase(movieDetail: movieDetail, showtime: showtime, seatQuantitySelected: seatQuantitySelected)
  }
}
