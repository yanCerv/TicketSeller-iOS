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
      let classifications = try await client.fetchClassification()
      self.classifications = classifications
    } catch {
      if let error = error as? ErrorHandler {
        self.errorMessage = error.message
        self.showError = true
      }
    }
  }
}
