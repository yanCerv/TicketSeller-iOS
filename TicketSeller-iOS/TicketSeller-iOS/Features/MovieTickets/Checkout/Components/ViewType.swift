//
//  ViewType.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 24/10/25.
//

import Foundation

enum ViewType: Hashable, Identifiable {
  case card
  case purchase

  var id: Int {
    hashValue
  }
}
