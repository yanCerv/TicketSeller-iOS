//
//  LocaleManager.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 30/10/25.
//

import Foundation

enum LocaleManager {
  
  static var deviceLanguageCode: String {
    Locale.preferredLanguages.first?.prefix(2).lowercased() ?? "es"
  }

  static var deviceCountryCode: String {
    Locale.current.region?.identifier ?? "MX"
  }

  static var localizedCountryName: String {
    Locale.current.localizedString(forRegionCode: deviceCountryCode) ?? "México"
  }

  static func detectedCountryModel(from list: [AppCountry]) -> AppCountry? {
    list.first {
      $0.countryCode.lowercased() == deviceCountryCode.lowercased()
    }
  }

  static func bestLanguage(from supportedLanguages: [String]) -> String {
    for lang in Locale.preferredLanguages {
      let code = String(lang.prefix(2)).lowercased()
      if supportedLanguages.contains(code) {
        return code
      }
    }
    return "es"
  }
}
