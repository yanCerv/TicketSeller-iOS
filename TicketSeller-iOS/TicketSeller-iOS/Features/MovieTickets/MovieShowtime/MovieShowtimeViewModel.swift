//
//  MovieSwhotimeViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

@Observable
final class MovieShowtimeViewModel {
  
  private let client: MoviesProvider = MoviesClient()
  
  var movieDetail: MovieDetail?
  var movieShowtime: MovieShowtime?
  var showtimeSelected: Showtime!
  var seatQuantity: Int = 0
  var showSeatQuantitySelection: Bool = false
  
  var alertMessage: String = ""
  var showAlert: Bool = false
  
  var navigateToSeatSelection: (MoviesNavigationPath) -> Void = { _ in }

  var movieId: Int
  var favoriteMovies: [AddFavoriteMovieResponse] = []
  
  var movieDetailWrapped: MovieDetail {
    guard let movieDetail else { return MovieDetail.emptyObject() }
    return movieDetail
  }
  
  var movieShowtimeWrapped: MovieShowtime {
    guard let movieShowtime else { return MovieShowtime.emptyObject() }
    return movieShowtime
  }
  
  var isMovieFavoriteAlready: Bool = false
  
  //MARK: Init
  
  init(movieId: Int) {
    self.movieId = movieId
  }
  
  //TODO: validate Date Time... if current dateTime is after showtime, deactivate option
  func didFetchData() async {
    guard movieDetail == nil else { return }
    await fetchFavorites()
    do {
      let detail = try await client.fetchMovieDetail(id: movieId)
      movieDetail = detail
      movieShowtime = try await client.fetchMovieShowtime(id: detail.id)
    } catch {
      if let error = error as? ErrorHandler {
        alertMessage = error.message
        showAlert = true
      }
    }
  }
  
  func validateDateTime(showtime: Showtime) {
    
  }
  
  func didSelected(_ showtime: Showtime) {
    showtimeSelected = showtime
    showSeatQuantitySelection = true
  }
  
  func didSelecteSeat(quantity: Int) {
    seatQuantity = quantity
    showSeatQuantitySelection = false
    
    if let movieDetail {
      let path = MoviesNavigationPath.seatSelection(showtime: showtimeSelected, movieDetail: movieDetail, seatQuantitySelected: seatQuantity)
      navigateToSeatSelection(path)
    }
  }
  
  private func addFavorite(movieId: Int) async {
    do {
      let movieFavorite = try await client.addFavorite(movieId: movieId)
      alertMessage = "\(movieFavorite.title) was added correctly to favorites!"
      showAlert = true
      isMovieFavoriteAlready = true
    } catch {
      debugPrint(error.localizedDescription)
    }
  }
  
  private func fetchFavorites() async {
    do {
      let favoriteMovies = try await client.fetchFavoriteMovies()
      self.favoriteMovies = favoriteMovies
      isMovieFavoriteAlready = favoriteMovies.contains(where: { $0.tmdbMovieId == movieId })
    } catch {
      debugPrint(error.localizedDescription)
    }
  }
}

//MARK: - Quantity selection Output

extension MovieShowtimeViewModel: SeatQuantitySelectionOutput {
  func didSelect(quantity: Int) {
    didSelecteSeat(quantity: quantity)
  }
}

//MARK: - Header Output

extension MovieShowtimeViewModel: MovieHeaderOutput {
  func didSelectFavorite() async {
    await addFavorite(movieId: movieId)
  }
}
