//
//  MoviesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Combine

protocol MoviesProvider {
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
  @MainActor
  func fetchNowPlaying() async throws -> [Movie] {
    let data = try await fetchNowPlayingDTO()
    // handle error throw here
    return data.results
  }
  
  @MainActor
  func fetchNowPlayingDTO() async throws -> MovieResponseDTO {
    let requestModel = MoviesClientResources.fetchNowPlaying.requestModel
    return try await request(with: requestModel)
  }
  
  //MARK: - Popular
  @MainActor
  func fetchPopular() async throws -> [Movie] {
    let data = try await fetchNowPopularDTO()
    // handle error throw here
    return data.results
  }
  
  @MainActor
  func fetchNowPopularDTO() async throws -> MovieResponseDTO {
    let requestModel = MoviesClientResources.fetchPopular.requestModel
    return try await request(with: requestModel)
  }
  
  //MARK: - Top Rated
  @MainActor
  func fetchTopRated() async throws -> [Movie] {
    let data = try await fetchTopRatedDTO()

    return data.results
  }
  
  @MainActor
  func fetchTopRatedDTO() async throws -> MovieResponseDTO {
    let requestModel = MoviesClientResources.fetchTopRated.requestModel
    return try await request(with: requestModel)
  }
  
  //MARK: - Upcoming
  @MainActor
  func fetchUpcoming() async throws -> [Movie] {
    let data = try await fetchUpcomingDTO()
  
    return data.results
  }
  
  @MainActor
  func fetchUpcomingDTO() async throws -> MovieResponseDTO {
    let requestModel = MoviesClientResources.fetchUpcoming.requestModel
    return try await request(with: requestModel)
  }
  
  //MARK: - Movie Detail
  @MainActor
  func fetchMovieDetail(id: Int) async throws -> MovieDetail {
    let requestModel = MoviesClientResources.fetchDetail(movieId: id).requestModel
    return try await request(with: requestModel)
  }
  
  //MARK: - Mocks
  func fetchMovieShowtime(id: Int) async throws -> MovieShowtime {
    _ = await ShowtimeRepository(movieId: id)
    let movieShowtime = await ShowtimeRepository.getMovieShowtimes(from: id)
    return movieShowtime
  }
  
  @MainActor
  func fetchSeats() async -> [SeatRow] {
    let response = ResourceJSON.from(fileName: "SeatMap", type: SeatResponseDTO.self)
    let rows = response.rows
    return rows
  }
}
