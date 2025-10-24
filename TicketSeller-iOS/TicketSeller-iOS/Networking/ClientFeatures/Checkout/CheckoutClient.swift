//
//  ClientCheckout.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

protocol CheckoutProvider {
  func fetchPayMethods() async -> [PayMethod]
  func fetchPurchase() async -> Purchase
}

actor CheckoutClient: CheckoutProvider {
  
  func fetchPayMethods() async -> [PayMethod] {
    let response = ResourceJSON.from(fileName: "PayMethods", type: PayMethodsResponseDTO.self)
    let payMethods = response.result
    
    return payMethods
  }
  
  func fetchPurchase() async -> Purchase {
    let response = ResourceJSON.from(fileName: "Purchase", type: PurchaseResponseDTO.self)
    let purchase = response.result.bookingInfo
    
    return purchase
  }
}
