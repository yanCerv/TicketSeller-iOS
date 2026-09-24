//
//  Date+Extension.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 23/09/26.
//

import Foundation

extension Date {
  static func isAccessOrSessionExpired(using key: String) -> Bool {
    guard let dateExpireAccess = try? FileDataManager.load(String.self, from: key) else {
      return true
    }
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    
    guard let accessExpiresAt = formatter.date(from: dateExpireAccess) else {
      return true
    }
    
    return accessExpiresAt <= .now.addingTimeInterval(30)
  }
}
