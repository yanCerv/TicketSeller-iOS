//
//  String+Extension.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 23/09/26.
//

import Foundation

extension Optional where Wrapped == String {
  var isNilOrEmpty: Bool {
    self?.isEmpty ?? true
  }
  
  var isNotNilOrEmpty: Bool {
    !isNilOrEmpty
  }
}
