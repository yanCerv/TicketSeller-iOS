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
  private var isLoaded: Bool = false
  
  var nowPlaying: [Movie] = []
  var popularMovies: [Movie] = []
  var topRatedMovies: [Movie] = []
  var upcomingMovies: [Movie] = []
  var errorMessage: String = ""
  
  init(client: MoviesProvider = MoviesClient()) {
    self.client = client
  }
  
  func didReloadData() async {
    isLoaded = false
    await didFetchData()
  }
  
  @MainActor
  func didFetchData() async {
    guard !isLoaded else { return }
    
    let client = client
    
    do {
      async let nowPlaying = client.fetchNowPlaying()
      async let popular = client.fetchPopular()
      async let topRated = client.fetchTopRated()
      async let upcoming = client.fetchUpcoming()
      
      let (nowPlayingResult, popularResult, topRatedResult, upcomingResult) = try await (nowPlaying, popular, topRated, upcoming)
      
      self.nowPlaying = nowPlayingResult
      self.popularMovies = popularResult
      self.topRatedMovies = topRatedResult
      self.upcomingMovies = upcomingResult
      isLoaded = true
    } catch {
      isLoaded = true
      if let error = error as? ErrorHandler {
        errorMessage = error.message
      }
    }
  }
}
