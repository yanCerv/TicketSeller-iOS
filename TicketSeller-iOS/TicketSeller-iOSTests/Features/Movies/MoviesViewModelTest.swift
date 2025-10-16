//
//  MoviesViewModelTest.swift
//  TicketSeller-iOSTests
//
//  Created by Yan Cervantes on 16/10/25.
//

import XCTest
@testable import TicketSeller_iOS

final class MoviesViewModelTest: XCTestCase {
  
  var viewModel: MoviesViewModel!
  
  override func setUpWithError() throws {
    viewModel = MoviesViewModel(client: MockMoviesClient())
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
  }
  
  func testFetchMovieOnSuccess() async {
    XCTAssertNotNil(viewModel)
    
    await viewModel.didFetchMovies()
    
    XCTAssertFalse(viewModel.movies.isEmpty)
    XCTAssertTrue(viewModel.errorMessage.isEmpty)
  }
  
  final class MockMoviesClient: MoviesProvider {
    
    
    func fetchMovies() async throws -> [Movie] {
      return [Movie(id: 1, title: "", originalTitle: "", overview: "", posterPath: "", backdropPath: "", releaseDate: "", originalLanguage: "", voteAverage:  0.0)]
    }
  }
}
