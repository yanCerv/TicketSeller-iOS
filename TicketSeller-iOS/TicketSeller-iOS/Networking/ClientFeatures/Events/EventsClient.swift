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
  func fetchClassification() async throws -> [Classification]?
}

actor EventsClient: Request, EventsProvider, ErrorCompletion {
  
  let provider = APIProvider.host
    
  func fetchEvents(countryCode: String, size: Int) async throws -> [Event] {
    let result = try await fetchEvetnsDTO(countryCode: countryCode, size: size)
    
    return result.embedded.events
  }
  
  func fetchClassification() async throws -> [Classification]? {
    let result = try await fetchClassificationDTO()

    return result.embedded?.classifications
  }
  
  //MARK: - Methods PublisherData Result
  
  private func fetchEvetnsDTO(countryCode: String, size: Int) async throws -> EventsResponseDTO {
    let path = Paths.eventsByCountry
    let queryItems = [
      URLQueryItem(name: "countryCode", value: countryCode),
      URLQueryItem(name: "size", value: String(size))
    ]
    let requestModel = await RequestModel(path: path.rawValue, method: .get, queryItems: queryItems, provider: provider)
    
    return try await request(with: requestModel)
  }
  
  private func fetchClassificationDTO() async throws -> EventClassificationResponseDTO {
    let path = Paths.eventClassification
    let requestModel = await RequestModel(path: path.rawValue, method: .get, provider: provider)
    
    return try await request(with: requestModel)
  }
}
