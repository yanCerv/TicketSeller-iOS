//
//  PurchasesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 07/10/26.
//

protocol PurchasesProvider: Request {
  func purchase(model: PurchaseRequestModel) async throws -> PurchaseResponseModel
  func getPurchases() async throws -> [PurchaseResponseModel]
}

extension PurchasesProvider {
  func purchase(model: PurchaseRequestModel) async throws -> PurchaseResponseModel {
    let path = Paths.purchases
    let requestModel = RequestModel(path: path.rawValue, method: .post, requestBody: model)
    
    return try await request(with: requestModel)
  }
  
  func getPurchases() async throws -> [PurchaseResponseModel] {
    let requestModel = RequestModel(path: Paths.purchases.rawValue)
    return try await request(with: requestModel)
  }
}

actor PurchasesClient: PurchasesProvider {
  
}
