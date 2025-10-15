//
//  MoviesViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import SwiftUI

@Observable
final class MoviesViewModel {
  
  private let client: MoviesProvider
  var movies: [Movie] = []
  var errorMessage: String = ""
  
  init(client: MoviesProvider = MoviesClient()) {
    self.client = client
  }
  
  func didFetchMovies() async {
    do {
      let movies = try await client.fetchMovies()
      self.movies = movies
      debugPrint(movies)
    } catch {
      if let error = error as? ErrorHandler {
        errorMessage = error.message
      }
    }
  }
}
