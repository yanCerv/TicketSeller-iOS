//
//  PreferencesViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 02/10/26.
//

import SwiftUI

@Observable
final class PreferencesViewModel {
  private let client: MoviesProvider
  weak var navigation: NavigationPreferencesProvider?
  
  var favoriteMovieList: [AddFavoriteMovieResponse] = []
  
  var isLoading: Bool = false
  var showAlert: Bool = false
  var message: String = ""
  
  init(client: MoviesProvider = MoviesClient(), navigation: NavigationPreferencesProvider) {
    self.client = client
    self.navigation = navigation
  }
  
  func getUserFavorites() async {
    isLoading = true
    do {
      let favoriteMovies = try await client.fetchFavoriteMovies()
      favoriteMovieList = favoriteMovies
      isLoading = false
    } catch {
      if let error = error as? ErrorHandler {
        showAlert = true
        message = error.message
      }
      isLoading = false
    }
  }
  
  func didSelectFavorite(movieId: Int) async {
    isLoading = true
    defer { isLoading = false }

    do {
      let movie = try await client.fetchMovieDetail(id: movieId)
      navigation?.navigateTo(movie: movie)
    } catch {
      if let error = error as? ErrorHandler {
        showAlert = true
        message = error.message
      }
    }
  }
  
  private func removeFavorite(id: Int) async {
    isLoading = true
    defer { isLoading = false }

    do {
      let response = try await client.deleteFavorite(movieId: id)
      if response.success {
        navigation?.backTo()
      }
    } catch {
      if let error = error as? ErrorHandler {
        showAlert = true
        message = error.message
      }
    }
  }
}

extension PreferencesViewModel: MovieFavoriteDescriptionOutput {
  func didRemoveFavorite(id: Int) {
    Task {
      await removeFavorite(id: id)
    }
  }
}
