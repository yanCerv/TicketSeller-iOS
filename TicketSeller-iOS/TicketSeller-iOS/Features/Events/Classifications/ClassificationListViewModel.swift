//
//  ClassificationListViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 11/11/25.
//

import SwiftUI

@Observable
final class ClassificationListViewModel {
  
  private let client: EventsProvider
  
  var classifications: [Classification] = []
  var errorMessage: String = ""
  var showError: Bool = false
  
  init(client: EventsProvider = EventsClient()) {
    self.client = client
  }
  
  func fetchClassifications() async {
    do {
      if let classifications = try await client.fetchClassification() {
        self.classifications = classifications
      } else {
        //Empty State
        errorMessage = "No Founded (1001)"
        showError = true
      }
    } catch {
      if let error = error as? ErrorHandler {
        errorMessage = error.message
        showError = true
      }
    }
  }
}
