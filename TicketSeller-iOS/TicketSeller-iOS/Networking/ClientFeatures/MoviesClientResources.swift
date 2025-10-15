//
//  MoviesClientResources.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

enum MoviesClientResources {
  case fetchMovies
}

extension MoviesClientResources {
  
  var requestModel: RequestModel {
    switch self {
    case .fetchMovies: //TODO set language and region from configuration manager
      let path = Paths.movies
      let queryItems = [
        URLQueryItem(name: "language", value: "es"),
        URLQueryItem(name: "region", value: "MX"),
        URLQueryItem(name: "page", value: "1")
      ]
      return RequestModel(path: path.rawValue, method: .get, queryItems: queryItems)
    }
  }
}
