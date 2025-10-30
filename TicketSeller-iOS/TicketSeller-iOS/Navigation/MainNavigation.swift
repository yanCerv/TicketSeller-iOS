//
//  MainNavigation.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 28/10/25.
//

import SwiftUI
import Combine

enum AccountNavigationPath: Hashable {
  case editProfile
  case settings
  case purchases
}

final class AccountNavigation: ObservableObject {
  
  @Published var paths: [AccountNavigationPath]
  
  init(paths: [AccountNavigationPath] = []) {
    self.paths = paths
  }
  
  //MARK: Methods
  
  func add(_ path: AccountNavigationPath) {
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
