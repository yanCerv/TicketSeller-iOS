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
    
  @MainActor
  func fetchEvents(countryCode: String, size: Int) async throws -> [Event] {
    let result = try await fetchEvetnsDTO(countryCode: countryCode, size: size)
    
    return result.embedded.events
  }
  
  @MainActor
  func fetchClassification() async throws -> [Classification]? {
    let result = try await fetchClassificationDTO()

    return result.embedded?.classifications
  }
  
  //MARK: - Methods PublisherData Result
  
  @MainActor
  private func fetchEvetnsDTO(countryCode: String, size: Int) async throws -> EventsResponseDTO {
    let env = Env()
    let path = Paths.eventsByCountry
    let queryItems = [URLQueryItem(name: "countryCode", value: countryCode),
                      URLQueryItem(name: "size", value: "10"),
                      URLQueryItem(name: "apikey", value: env.get(.ticketmasterKey))]
    let requestModel = RequestModel(path: path.rawValue, method: .get, queryItems: queryItems, provider: .ticketmaster)
    
    return try await request(with: requestModel)
  }
  
  @MainActor
  private func fetchClassificationDTO() async throws -> EventClassificationResponseDTO {
    let env = Env()
    let path = Paths.eventClassification
    let queryItems = [URLQueryItem(name: "size", value: "10"),
                      URLQueryItem(name: "apikey", value: env.get(.ticketmasterKey))]
    let requestModel = RequestModel(path: path.rawValue, method: .get, queryItems: queryItems, provider: .ticketmaster)
    
    return try await request(with: requestModel)
  }
}

