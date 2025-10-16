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
}

actor MoviesClient: Request, MoviesProvider, ErrorCompletion {
  
  private var anyCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  func fetchNowPlaying() async throws -> [Movie] {
    
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchNowPlayingMoviesPublisher()
        .sink { completion in
          if let error = self.error(completion) { // Error
            continuation.resume(throwing: error)
          }
        } receiveValue: { responseData in // Response Data
          let result = responseData.results
          continuation.resume(returning: result)
        }.store(in: &anyCancellables)
    }
  }
  
  func fetchPopular() async throws -> [Movie] {
    
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchPopularMoviesPublisher()
        .sink { completion in
          if let error = self.error(completion) { // Error
            continuation.resume(throwing: error)
          }
        } receiveValue: { responseData in // Response Data
          let result = responseData.results
          continuation.resume(returning: result)
        }
        .store(in: &anyCancellables)
    }
  }
  
  func fetchTopRated() async throws -> [Movie] {
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchTopRatedMoviesPublisher()
        .sink { completion in
          if let error = self.error(completion) { // Error
            continuation.resume(throwing: error)
          }
        } receiveValue: { responseData in // Response Data
          let result = responseData.results
          continuation.resume(returning: result)
        }
        .store(in: &anyCancellables)
    }
  }
  
  func fetchUpcoming() async throws -> [Movie] {
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchUpcomingMoviesPublisher()
        .sink { completion in
          if let error = self.error(completion) { // Error
            continuation.resume(throwing: error)
          }
        } receiveValue: { responseData in // Response Data
          let result = responseData.results
          continuation.resume(returning: result)
        }
        .store(in: &anyCancellables)
    }
  }
  
  func fetchMovieDetail(id: Int) async throws -> MovieDetail {
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchMovieDetailsPublisher(movieId: id)
        .sink { completion in
          if let error = self.error(completion) { // Error
            continuation.resume(throwing: error)
          }
        } receiveValue: { responseData in // Response Data
          let result = responseData
          continuation.resume(returning: result)
        }
        .store(in: &anyCancellables)
    }
  }
  
  func fetchMovieShowtime(id: Int) async throws -> MovieShowtime {
    _ = await ShowtimeRepository(movieId: id)
    let movieShowtime = await ShowtimeRepository.getMovieShowtimes(from: id)
    return movieShowtime
  }
  
  //MARK: - Methods PublisherData Result
  
  private func fetchNowPlayingMoviesPublisher() -> PublisherResult<MovieResponseDTO> {
    let requestModel = MoviesClientResources.fetchNowPlaying.requestModel
    
    return request(with: requestModel)
  }
  
  private func fetchPopularMoviesPublisher() -> PublisherResult<MovieResponseDTO> {
    let requestModel = MoviesClientResources.fetchPopular.requestModel
    
    return request(with: requestModel)
  }
  
  private func fetchTopRatedMoviesPublisher() -> PublisherResult<MovieResponseDTO> {
    let requestModel = MoviesClientResources.fetchTopRated.requestModel
    
    return request(with: requestModel)
  }
  
  private func fetchUpcomingMoviesPublisher() -> PublisherResult<MovieResponseDTO> {
    let requestModel = MoviesClientResources.fetchUpcoming.requestModel
    
    return request(with: requestModel)
  }
  
  private func fetchMovieDetailsPublisher(movieId: Int) -> PublisherResult<MovieDetail> {
    let requestModel = MoviesClientResources.fetchDetail(movieId: movieId).requestModel
    
    return request(with: requestModel)
  }
}
