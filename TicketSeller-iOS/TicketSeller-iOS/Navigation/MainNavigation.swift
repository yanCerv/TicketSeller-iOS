//
//  MainNavigation.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 28/10/25.
//

import SwiftUI
import Combine

enum FeaturesNavigationPath: Hashable {
  case purchases
}

final class FeatureNavigation: ObservableObject {
  
  @Published var paths: [FeaturesNavigationPath]
  
  init(paths: [FeaturesNavigationPath] = []) {
    self.paths = paths
  }
  
  //MARK: Methods
  
  func add(_ path: FeaturesNavigationPath) {
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
