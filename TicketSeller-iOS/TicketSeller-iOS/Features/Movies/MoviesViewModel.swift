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
  var nowPlaying: [Movie] = []
  var popularMovies: [Movie] = []
  var topRatedMovies: [Movie] = []
  var upcomingMovies: [Movie] = []
  var errorMessage: String = ""
  
  init(client: MoviesProvider = MoviesClient()) {
    self.client = client
  }
  
  func didFetchData() async {
    await withThrowingTaskGroup(of: Void.self) { group in
      group.addTask {
        let movies = try await self.client.fetchNowPlaying()
        self.nowPlaying = movies
      }

      group.addTask {
        let movies = try await self.client.fetchPopular()
        self.popularMovies = movies
      }

      group.addTask {
        let movies = try await self.client.fetchTopRated()
        self.topRatedMovies = movies
      }

      group.addTask {
        let movies = try await self.client.fetchUpcoming()
        self.upcomingMovies = movies
      }

      do {
        try await group.waitForAll()
      } catch {
        if let error = error as? ErrorHandler {
          self.errorMessage = error.message
        }
      }
    }
  }
}
