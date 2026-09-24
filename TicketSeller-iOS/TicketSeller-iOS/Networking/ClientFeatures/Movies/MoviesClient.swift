//
//  MoviesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

protocol MoviesProvider: Sendable {
  func fetchNowPlaying() async throws -> [Movie]
  func fetchPopular() async throws -> [Movie]
  func fetchTopRated() async throws -> [Movie]
  func fetchUpcoming() async throws -> [Movie]
  func fetchMovieDetail(id: Int) async throws -> MovieDetail
  func fetchMovieShowtime(id: Int) async throws -> MovieShowtime
  func fetchSeats() async -> [SeatRow]
}

actor MoviesClient: Request, MoviesProvider, ErrorCompletion {
  
  //MARK: - Now Playing

  func fetchNowPlaying() async throws -> [Movie] {
    let data = try await fetchNowPlayingDTO()
    // handle error throw here
    return data.results
  }
  
  func fetchNowPlayingDTO() async throws -> MovieResponseDTO {
    let path = Paths.nowPlaying
    let requestModel = await RequestModel(path: path.rawValue, provider: .movieDB)
    return try await request(with: requestModel)
  }
  
  //MARK: - Popular
  func fetchPopular() async throws -> [Movie] {
    let data = try await fetchNowPopularDTO()
    // handle error throw here
    return data.results
  }
  
  func fetchNowPopularDTO() async throws -> MovieResponseDTO {
    let path = Paths.popular
    let requestModel = await RequestModel(path: path.rawValue, provider: .movieDB)
    return try await request(with: requestModel)
  }
  
  //MARK: - Top Rated
  func fetchTopRated() async throws -> [Movie] {
    let data = try await fetchTopRatedDTO()

    return data.results
  }
  
  func fetchTopRatedDTO() async throws -> MovieResponseDTO {
    let path = Paths.topRated
    let requestModel = await RequestModel(path: path.rawValue, provider: .movieDB)
    return try await request(with: requestModel)
  }
  
  //MARK: - Upcoming
  func fetchUpcoming() async throws -> [Movie] {
    let data = try await fetchUpcomingDTO()
  
    return data.results
  }
  
  func fetchUpcomingDTO() async throws -> MovieResponseDTO {
    let path = Paths.upcoming
    let requestModel = await RequestModel(path: path.rawValue, provider: .movieDB)
    return try await request(with: requestModel)
  }
  
  //MARK: - Movie Detail
  func fetchMovieDetail(id: Int) async throws -> MovieDetail {
    let path = "\(Paths.movieDetail.rawValue)/\(id)"
    let requestModel = await RequestModel(path: path, provider: .movieDB)
    return try await request(with: requestModel)
  }
  
  //MARK: - Mocks
  func fetchMovieShowtime(id: Int) async throws -> MovieShowtime {
    _ = await ShowtimeRepository(movieId: id)
    let movieShowtime = await ShowtimeRepository.getMovieShowtimes(from: id)
    return movieShowtime
  }
  
  func fetchSeats() async -> [SeatRow] {
    let response = ResourceJSON.from(fileName: "SeatMap", type: SeatResponseDTO.self)
    let rows = response.rows
    return rows
  }
}
