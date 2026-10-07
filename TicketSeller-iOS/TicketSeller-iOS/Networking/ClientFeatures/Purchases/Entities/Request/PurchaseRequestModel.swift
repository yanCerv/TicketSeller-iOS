//
//  PurchaseRequestModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 07/10/26.
//

nonisolated struct PurchaseRequestModel: Encodable, Sendable {
  let showtimeId: String
  let seatIds: [String]
  let buyer: Buyer
  let payment: Payment
}

nonisolated struct Buyer: Encodable, Sendable {
  let firstName: String
  let lastName: String
  let email: String
}

nonisolated struct Payment: Encodable, Sendable {
  let cardNumber: String
  let expiry: String
  let cvc: String
}
