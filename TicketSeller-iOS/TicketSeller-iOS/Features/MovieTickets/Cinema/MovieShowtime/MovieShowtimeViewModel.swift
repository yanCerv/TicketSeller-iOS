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
  var errorMessage: String = ""

  var movieId: Int
  
  var movieDetailWrapped: MovieDetail {
    guard let movieDetail else { return MovieDetail.emptyObject() }
    return movieDetail
  }
  
  var movieShowtimeWrapped: MovieShowtime {
    guard let movieShowtime else { return MovieShowtime.emptyObject() }
    return movieShowtime
  }
  
  //MARK: Init
  
  init(movieId: Int) {
    self.movieId = movieId
  }
  //TODO: validate Date Time... if current dateTime is after showtime, deactivate option
  func didFetchData() async {
    guard movieDetail == nil else { return }
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
  
  func validateDateTime(showtime: Showtime) {
    
  }
  
  func didSelected(_ showtime: Showtime) {
    showtimeSelected = showtime
    showSeatQuantitySelection = true
  }
  
  func didSelecteSeat(quantity: Int) {
    seatQuantity = quantity
    showSeatQuantitySelection = false
  }
}

extension MovieShowtimeViewModel: SeatQuantitySelectionOutput {
  func didSelect(quantity: Int) {
    didSelecteSeat(quantity: quantity)
  }
}
