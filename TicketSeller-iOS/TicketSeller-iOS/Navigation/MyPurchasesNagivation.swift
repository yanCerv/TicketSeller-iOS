//
//  MyPurchasesNagivation.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 04/11/25.
//

import SwiftUI
import Combine

enum MyPurchasesNagivationPath: Hashable {
  case purchaseDetail
}

final class MyPurchasesNagivation: ObservableObject {
  
  @Published var paths: [MyPurchasesNagivationPath]
  
  init(paths: [MyPurchasesNagivationPath] = []) {
    self.paths = paths
  }
  
  //MARK: Methods
  
  func add(_ path: MyPurchasesNagivationPath) {
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
