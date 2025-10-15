//
//  MoviesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Combine

protocol MoviesProvider {
  func fetchMovies() async throws -> [Movie]
}

actor MoviesClient: Request, MoviesProvider, ErrorCompletion {
  
  private var anyCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  func fetchMovies() async throws -> [Movie] {
    
    return try await withCheckedThrowingContinuation { continuation in
      self.fetchMoviesPublisher()
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
  
  //MARK: - Methods PublisherData Result
  
  private func fetchMoviesPublisher() -> PublisherResult<MovieResponseDTO> {
    let requestModel = MoviesClientResources.fetchMovies.requestModel
    
    return request(with: requestModel)
  }
}
