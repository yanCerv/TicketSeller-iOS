//
//  EventListViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI

@Observable
final class EventListViewModel {
  
  private let client: EventsProvider
  
  var events: [Event] = []
  var showError: Bool = false
  var errorMessage: String = ""
  var isLoaded: Bool = false
  var isLoading: Bool = false
  
  init(client: EventsProvider = EventsClient()) {
    self.client = client
  }
  
  func fetchEvents() async {
    guard !isLoaded else { return }
    do {
      let events = try await client.fetchEvents(countryCode: "MX", size: 10)
      self.events = events
      isLoaded = true      
    } catch {
      if let error = error as? ErrorHandler {
        self.errorMessage = error.message
      }
    }
  }
}
