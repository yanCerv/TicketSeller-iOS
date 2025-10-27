//
//  MoviesClientResources.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

enum MoviesClientResources {
  case fetchNowPlaying
  case fetchPopular
  case fetchTopRated
  case fetchUpcoming
  case fetchDetail(movieId: Int)
}

extension MoviesClientResources {
  
  var requestModel: RequestModel {
    switch self {
    case .fetchNowPlaying: //TODO set language and region from configuration manager
      let path = Paths.nowPlaying
      return RequestModel(path: path.rawValue, queryItems: queryItems())
    case .fetchPopular:
      let path = Paths.popular
      return RequestModel(path: path.rawValue, queryItems: queryItems())
    case .fetchTopRated:
      let path = Paths.topRated
      return RequestModel(path: path.rawValue, queryItems: queryItems())
    case .fetchUpcoming:
      let path = Paths.upcoming
      return RequestModel(path: path.rawValue, queryItems: queryItems())
    case .fetchDetail(let id):
      let path = "\(Paths.movieDetail.rawValue)/\(id)"
      return RequestModel(path: path, queryItems: queryItems(havePage: false))
    }
  }
  
  private func queryItems(havePage: Bool = true) -> [URLQueryItem] {
    var items: [URLQueryItem] = []
    items.append(URLQueryItem(name: "language", value: "es-MX"))
    if havePage {
      items.append(URLQueryItem(name: "page", value: "1"))
    }
    return items
  }
}
