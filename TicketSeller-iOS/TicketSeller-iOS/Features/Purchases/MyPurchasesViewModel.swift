//
//  PurchasesViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 04/11/25.
//

import SwiftUI

@Observable
final class MyPurchasesViewModel {
  private let client: PurchasesProvider
  
  var purchases: [PurchaseResponseModel] = []
  
  var isLoading: Bool = false
  var showAlert: Bool = false
  var message: String = ""
  
  init(client: PurchasesProvider = PurchasesClient()) {
    self.client = client
  }
  
  @MainActor
  func getPurchases() async {
    
    do {
      let response = try await client.getPurchases()
      self.purchases = response
    } catch {
      if let error = error as? ErrorHandler {
        message = error.message
        showAlert = true
      }
    }
  }
}
