//
//  MoviesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

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
    let path = Paths.nowPlaying
    let queryItems = queryItems()
    let requestModel = RequestModel(path: path.rawValue, queryItems: queryItems)
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
    let path = Paths.popular
    let queryItems = queryItems()
    let requestModel = RequestModel(path: path.rawValue, queryItems: queryItems)
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
    let path = Paths.topRated
    let queryItems = queryItems()
    let requestModel = RequestModel(path: path.rawValue, queryItems: queryItems)
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
    let path = Paths.upcoming
    let queryItems = queryItems()
    let requestModel = RequestModel(path: path.rawValue, queryItems: queryItems)
    return try await request(with: requestModel)
  }
  
  //MARK: - Movie Detail
  @MainActor
  func fetchMovieDetail(id: Int) async throws -> MovieDetail {
    let path = "\(Paths.movieDetail.rawValue)/\(id)"
    let queryItems = queryItems()
    let requestModel = RequestModel(path: path, queryItems: queryItems)
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
  
  @MainActor
  private func queryItems(havePage: Bool = true) -> [URLQueryItem] {
    var items: [URLQueryItem] = []
    items.append(URLQueryItem(name: "language", value: "es-MX"))
    if havePage {
      items.append(URLQueryItem(name: "page", value: "1"))
    }
    return items
  }
}
