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
  
  func testFetchMovieOnSuccess() {
    XCTAssertNotNil(viewModel)
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  final class MockMoviesClient: MoviesProvider {
    func fetchMovies() async throws -> [Movie] {
      return []
    }
  }
}
