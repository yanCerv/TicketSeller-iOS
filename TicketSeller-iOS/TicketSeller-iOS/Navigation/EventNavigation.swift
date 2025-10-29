//
//  EventNavigation.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI
import Combine

enum EventNavigationPath: Hashable {
  case purchases
}

final class EventNavigation: ObservableObject {
  
  @Published var paths: [EventNavigationPath]
  
  init(paths: [EventNavigationPath] = []) {
    self.paths = paths
  }
  
  //MARK: Methods
  
  func add(_ path: EventNavigationPath) {
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
