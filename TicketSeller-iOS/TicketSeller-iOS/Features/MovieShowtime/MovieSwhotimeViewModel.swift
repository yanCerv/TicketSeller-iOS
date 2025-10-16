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
  
  var movieDetail: MovieDetail?
  var movieShowtime: MovieShowtime?
  var errorMessage: String = ""
  
  var movieId: Int
  
  init(movieId: Int) {
    self.movieId = movieId
  }
  
  func didFetchData() async {
    do {
      let detail = try await client.fetchMovieDetail(id: movieId)
      movieDetail = detail
      movieShowtime = try await client.fetchMovieShowtime(id: detail.id)
    } catch {
      if let error = error as? ErrorHandler {
        errorMessage = error.message
      }
    }
  }
}
