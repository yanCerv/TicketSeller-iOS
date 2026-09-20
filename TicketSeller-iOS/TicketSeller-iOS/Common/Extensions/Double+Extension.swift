//
//  Double+Extension.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 24/10/25.
//

import Foundation

extension Double {
  
  func formattedPrice() -> String {
    String(format: "%.2f", self)
  }
  
  func asCurrency() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    formatter.currencySymbol = "$"
    return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
  }
}
