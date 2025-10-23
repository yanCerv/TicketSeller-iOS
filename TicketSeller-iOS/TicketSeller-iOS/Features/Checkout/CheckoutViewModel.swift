//
//  CheckoutViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

import SwiftUI

@Observable
final class CheckoutViewModel {
  
  private let client: CheckoutProvider
  private var dataPurchase: DataPurchase
  
  var movieDetail: MovieDetail!
  var selectedSeats: [Seat]!
  var showtime: Showtime!
  var selectedPayMethod: PayMethod?
  
  var payMethodList: [PayMethod] = []
  var firstName: String = ""
  var lastName: String = ""
  var email: String = ""
  var isLoaded: Bool = false
  
  var isFirstNameValid: Bool {
    firstName.count > 3
  }
  
  var isLastNameValid: Bool {
    lastName.count > 3
  }
  
  var isEmailValid: Bool {
    email.contains("@") && email.contains(".") && email.count > 6
  }
  
  var isFormValid: Bool {
    isFirstNameValid && isLastNameValid && isEmailValid
  }
  
  //MARK: Init
  
  init(dataPurchase: DataPurchase, client: CheckoutProvider = CheckoutClient()) {
    self.dataPurchase = dataPurchase
    self.client = client
    movieDetail = dataPurchase.movieDetail
    selectedSeats = dataPurchase.selectedSeats
    showtime = dataPurchase.showtime
  }
  
  //MARK: Methods
  
  func fetchPayMethodList() async {
    guard !isLoaded else { return }
    let payMethodList = await client.fetchPayMethods()
    
    self.payMethodList = payMethodList
    isLoaded = true
  }
  
  func didSelect(payMethod: PayMethod) {
    selectedPayMethod = payMethod
  }
}
