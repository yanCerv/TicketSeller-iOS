//
//  PurchaseViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 24/10/25.
//

import SwiftUI

@Observable
final class PurchaseViewModel {
  let dataPurchase: DataPurchase
  weak var checkoutInput: CheckoutInput!
  var purchase: Purchase!
  var showtime: Showtime!
  var movieDetail: MovieDetail!
  var seats: [Seat] = []
  
  //MARK: Init
  
  init(dataPurchase: DataPurchase, checkoutInput: CheckoutInput) {
    self.dataPurchase = dataPurchase
    self.checkoutInput = checkoutInput
    purchase = dataPurchase.purchase
    showtime = dataPurchase.showtime
    movieDetail = dataPurchase.movieDetail
    seats = dataPurchase.selectedSeats
  }
  
  //MARK: Methods
  
  //MARK: Pricate Methods
}
