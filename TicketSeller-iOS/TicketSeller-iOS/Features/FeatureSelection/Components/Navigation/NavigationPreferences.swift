//
//  NavigationPreferences.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 06/10/26.
//

import SwiftUI

enum PreferencesNavigationpath: Hashable {
  case navigateToMovie(movie: MovieDetail)
}

@Observable
final class NavigationPreferences {
  var paths: [PreferencesNavigationpath]
  
  init(paths: [PreferencesNavigationpath] = []) {
    self.paths = paths
  }
  
  //MARK: Methods
  
  func add(_ path: PreferencesNavigationpath) {
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
