//
//  Paths.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

enum Paths: String, CaseIterable {
  // Movies
  case nowPlaying = "/api/v1/movies/now-playing"
  case popular = "/api/v1/movies/popular"
  case topRated = "/api/v1/movies/top-rated"
  case upcoming = "/api/v1/movies/upcoming"
  case movieDetail = "/api/v1/movies"
  
  // Events
  case eventsByCountry = "/discovery/v2/events"
  case eventClassification = "/discovery/v2/classifications.json"
  case eventClassificationDetail = "/discovery/v2/classifications/"
  
  //Account
  case register = "/api/v1/auth/register"
  case login = "/api/v1/auth/login"
  case logout = "/api/v1/auth/logout"
  case account = "/api/v1/users/me"
  case refresh = "/api/v1/auth/refresh"
}
