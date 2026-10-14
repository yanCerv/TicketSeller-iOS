//
//  MyPurchasesNavigation.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 14/10/26.
//

import Foundation

import SwiftUI

enum MyPurchasesNavigationpath: Hashable {
  case navigateToDetail(purchase: PurchaseResponseModel)
}

@Observable
final class MyPurchasesNavigation {
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
