//
//  EventsClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import Foundation
import Combine

protocol EventsProvider {
  func fetchEvents(countryCode: String, size: Int) async throws -> [Event]
  func fetchClassification() async throws -> [Classification]
}

actor EventsClient: Request, EventsProvider, ErrorCompletion {
  
  private var anyCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  func fetchEvents(countryCode: String, size: Int) async throws -> [Event] {
    
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchEvetnsPublisherResult(countryCode: countryCode, size: size)
        .sink { completion in
          if let error = self.error(completion) {
            continuation.resume(throwing: error)
          }
        } receiveValue: { responseData in
          let result = responseData.embedded
          continuation.resume(returning: result.events)
        }.store(in: &anyCancellables)
    }
  }
  
  func fetchClassification() async throws -> [Classification] {
    
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchClassificationPublisherResult()
        .sink { completion in
          if let error = self.error(completion) {
            continuation.resume(throwing: error)
          }
        } receiveValue: { responseData in
          if let result = responseData.embedded?.classifications {
            continuation.resume(returning: result)
          } else {
            continuation.resume(throwing: ErrorHandler.error(message: "No Classifications Founded", statusCode: 1))
          }
        }.store(in: &anyCancellables)
    }
  }
  
  //MARK: - Methods PublisherData Result
  
  private func fetchEvetnsPublisherResult(countryCode: String, size: Int) -> PublisherResult<EventsResponseDTO> {
    let requestModel = EventsClientResources.fetchEventsBy(countryCode).requestModel
    
    return request(with: requestModel)
  }
  
  private func fetchClassificationPublisherResult() -> PublisherResult<EventClassificationResponseDTO> {
    let requestModel = EventsClientResources.classifications.requestModel
    
    return request(with: requestModel)
  }
}

