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
    
    await viewModel.didFetchData()
    
    XCTAssertFalse(viewModel.nowPlaying.isEmpty)
    XCTAssertFalse(viewModel.popularMovies.isEmpty)
    XCTAssertFalse(viewModel.topRatedMovies.isEmpty)
    XCTAssertFalse(viewModel.upcomingMovies.isEmpty)
    XCTAssertTrue(viewModel.errorMessage.isEmpty)
  }
  
  final class MockMoviesClient: MoviesProvider {
    
    private let emptyObject = [Movie(id: 1, title: "", originalTitle: "", overview: "", posterPath: "", backdropPath: "", releaseDate: "", originalLanguage: "", voteAverage:  0.0)]

    
    func fetchNowPlaying() async throws -> [Movie] {
      return emptyObject
    }
    
    func fetchPopular() async throws -> [Movie] {
      return emptyObject
    }
    
    func fetchTopRated() async throws -> [Movie] {
      return emptyObject
    }
    
    func fetchUpcoming() async throws -> [Movie] {
      return emptyObject
    }
    
    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
      MovieDetail.emptyObject()
    }
    
    func fetchMovieShowtime(id: Int) async throws -> MovieShowtime {
      MovieShowtime.emptyObject()
    }
  }
}
