//
//  MovieSwhotimeViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

@Observable
final class MovieSwhotimeViewModel {
  
  private let client: MoviesProvider = MoviesClient()
  
  var moveDetail: MovieDetail?
  var errorMessage: String = ""
  
  var movieId: Int
  
  init(movieId: Int) {
    self.movieId = movieId
  }
  
  func didFetchData() async {
    do {
      let detail = try await client.fetchMovieDetail(id: movieId)
    } catch {
      if let error = error as? ErrorHandler {
        errorMessage = error.message
      }
    }
  }
}
