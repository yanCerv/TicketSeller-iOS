//
//  MainNavigation.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI
import Combine

enum MoviesNavigationPath: Hashable {
  case movieShowtimeDetail(id: Int)
  case seatSelection(showtime: Showtime, movieDetail: MovieDetail, seatQuantitySelected: Int)
  case checkout(dataPurchase: DataPurchase)
}

final class MoviesNavigation: ObservableObject {
  
  @Published var paths: [MoviesNavigationPath]
  
  init(paths: [MoviesNavigationPath] = []) {
    self.paths = paths
  }
  
  //MARK: Methods
  
  func add(_ path: MoviesNavigationPath) {
    paths.append(path)
  }
  
  func back() {
    guard !paths.isEmpty else { return }
    paths.removeLast()
  }
  
  func backToMain() {
    paths.removeAll()
  }
}
