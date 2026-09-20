//
//  Bundle+Extension.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import Foundation

extension Bundle {
  static var appVersion: String {
    let version = main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "–"
    let build = main.infoDictionary?["CFBundleVersion"] as? String ?? "–"
    return "Version: \(version) (\(build))"
  }
}
