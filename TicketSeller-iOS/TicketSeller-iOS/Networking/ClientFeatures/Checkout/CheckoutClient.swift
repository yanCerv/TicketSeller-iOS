//
//  ClientCheckout.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

protocol CheckoutProvider {
  func fetchPayMethods() async -> [PayMethod]
}

actor CheckoutClient: CheckoutProvider {
  
  func fetchPayMethods() async -> [PayMethod] {
    let response = ResourceJSON.from(fileName: "PayMethods", type: PayMethodsResponseDTO.self)
    let payMethods = response.result
    
    return payMethods
  }
}
