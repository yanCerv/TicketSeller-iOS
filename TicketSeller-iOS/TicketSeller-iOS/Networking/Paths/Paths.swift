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
  case showtimes = "/api/v1/movies/"
  case addFavorite = "/api/v1/favorites/movies/"
  case modifyFavorite = "/api/v1/favorites/movies"
  
  // Events
  case eventsByCountry = "/api/v1/events"
  case eventClassification = "/api/v1/events/classifications"
  
  //Account
  case register = "/api/v1/auth/register"
  case login = "/api/v1/auth/login"
  case google = "/api/v1/auth/google"
  case requestLoginCode = "/api/v1/auth/request-login-code"
  case verifyLoginCode = "/api/v1/auth/verify-login-code"
  case forgotPassword = "/api/v1/auth/forgot-password"
  case resetPassword = "/api/v1/auth/reset-password"
  case logout = "/api/v1/auth/logout"
  case account = "/api/v1/users/me"
  case refresh = "/api/v1/auth/refresh"
  
  func showtime(with movieId: Int, date: String) -> String {
    return "/api/v1/movies/\(movieId)/showtimes?date=\(date)"
  }
  
  static func isRequiredValidateAccess(with modelPath: String) -> Bool {
    let publicPaths: Set<String> = [
      Paths.register.rawValue,
      Paths.login.rawValue,
      Paths.google.rawValue,
      Paths.requestLoginCode.rawValue,
      Paths.verifyLoginCode.rawValue,
      Paths.forgotPassword.rawValue,
      Paths.resetPassword.rawValue,
      Paths.refresh.rawValue,
      Paths.logout.rawValue
    ]
    return !publicPaths.contains(modelPath)
  }
}
