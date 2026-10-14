//
//  ClientCheckout.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

protocol CheckoutProvider: Request {
  func fetchPayMethods() async throws -> PayMethodsResponseDTO
}

actor CheckoutClient: CheckoutProvider {
  
  func fetchPayMethods() async throws -> PayMethodsResponseDTO {
    let path = Paths.paymentMethods.rawValue
    let requestModel = await RequestModel(path: path, isAuthorized: false)
    
    return try await request(with: requestModel)
  }
}
