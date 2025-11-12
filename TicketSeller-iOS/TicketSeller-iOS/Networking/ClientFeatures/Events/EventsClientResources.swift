//
//  EventsClientResources.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import Foundation

enum EventsClientResources {
  case fetchEventsBy(_ countryId: String)
  case classifications
}

extension EventsClientResources {
  
  private var env: Env {
    return Env()
  }
  
  var requestModel: RequestModel {
    switch self {
    case .fetchEventsBy(let countryId):
      let path = Paths.eventsByCountry
      let queryItems = [URLQueryItem(name: "countryCode", value: countryId),
                        URLQueryItem(name: "size", value: "10"),
                        URLQueryItem(name: "apikey", value: env.get(.ticketmasterKey))]
      return RequestModel(path: path.rawValue, method: .get, queryItems: queryItems, provider: .ticketmaster)
    case .classifications:
      let path = Paths.eventClassification
      let queryItems = [URLQueryItem(name: "size", value: "10"),
                        URLQueryItem(name: "apikey", value: env.get(.ticketmasterKey))]
      return RequestModel(path: path.rawValue, method: .get, queryItems: queryItems, provider: .ticketmaster)
    }
  }
}
