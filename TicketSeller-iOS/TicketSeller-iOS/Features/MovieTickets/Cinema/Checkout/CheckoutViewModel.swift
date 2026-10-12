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
  private let purchasesClient: PurchasesProvider
  private(set) var dataPurchase: DataPurchase
  
  var movieDetail: MovieDetail!
  var selectedSeats: [Seat]!
  var showtime: Showtime!
  var card: Card!
  var selectedPayMethod: PayMethod?
  
  var payMethodList: [PayMethod] = []
  
  var firstName: String = ""
  var lastName: String = ""
  var email: String = ""
  
  var cardName: String = ""
  var cardNumber: String = ""
  var cardDate: String = ""
  var cardCvc: String = ""
  
  var price: String = ""
  
  var isLoaded: Bool = false
  var isLoading: Bool = false
  var viewType: ViewType? = nil
  
  var isFirstNameValid: Bool {
    firstName.count > 3
  }
  
  var isLastNameValid: Bool {
    lastName.count > 3
  }
  
  var isEmailValid: Bool {
    email.contains("@") && email.contains(".") && email.count > 6
  }
  
  var isCardFilled: Bool {
    cardNumber.count >= 16
  }
  
  var isFormValid: Bool {
    isFirstNameValid && isLastNameValid && isEmailValid
  }
  
  //MARK: Init
  
  init(dataPurchase: DataPurchase, client: CheckoutProvider = CheckoutClient(), purchasesClient: PurchasesProvider = PurchasesClient()) {
    self.dataPurchase = dataPurchase
    self.client = client
    self.purchasesClient = purchasesClient
    movieDetail = dataPurchase.movieDetail
    selectedSeats = dataPurchase.selectedSeats
    showtime = dataPurchase.showtime
  }
  
  //MARK: Methods
  
  func fetchPayMethodList() async {
    guard !isLoaded else { return }
    let payMethodList = await client.fetchPayMethods()
    
    self.payMethodList = payMethodList
    
    price = dataPurchase.totalPrice.formattedPrice()
    
    isLoaded = true
  }
  
  func didSelect(payMethod: PayMethod) {
    selectedPayMethod = payMethod
    viewType = .card
  }
  
  func didSet(text: String, from: TextType) {
    switch from {
    case .name:
      cardName = text
    case .card:
      let cleaned = cleaned(text, maxLenght: 19)
      if cardNumber != cleaned {
        cardNumber = cleaned
      }
    case .date:
      let cleaned = cleaned(text, maxLenght: 4, isExpiry: true)
      if cardDate != cleaned {
        cardDate = cleaned
      }
    case .cvc:
      let cleaned = text.filter(\.isNumber)
      let limited = String(cleaned.prefix(4))
      if cardCvc != limited {
        cardCvc = limited
      }
    }
  }
  
  func didTapPurchase() {
    guard isPaymentFormValid else { return }

    isLoading = true
    viewType = nil
    
    let buyer = Buyer(firstName: firstName, lastName: lastName, email: email)
    let payment = Payment(cardNumber: cardNumber, expiry: cardDate, cvc: cardCvc)
    let seatsId = dataPurchase.selectedSeats.map(\.id)
    let showtimeId = dataPurchase.showtime.id
    
    Task {
      do {
        let request = PurchaseRequestModel(showtimeId: showtimeId, seatIds: seatsId, buyer: buyer, payment: payment)
        let purchase = try await purchasesClient.purchase(model: request)
        dataPurchase.purchase = purchase
        isLoading = false
        viewType = .purchase
      } catch {
        isLoading = false
        debugPrint(error.localizedDescription)
      }
    }
  }
  
  //MARK: Private methods
  
  private func cleaned(_ text: String, maxLenght: Int, isExpiry: Bool = false) -> String {
    let cleaned = text.filter(\.isNumber)
    if isExpiry {
      return cleaned.formattedExpiry(maxLength: maxLenght)
    } else {
      let limited = String(cleaned.prefix(16))
      return limited.cardStringFormat()
    }
  }

  private var isPaymentFormValid: Bool {
    isCardFilled && cardName.count > 3 && cardDate.count == 5 && cardCvc.count >= 3
  }
}

extension CheckoutViewModel: CheckoutInput {
  func didTapSaveAndExit() {
    viewType = nil
  }
}
