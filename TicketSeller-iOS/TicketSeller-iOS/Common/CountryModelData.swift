//
//  CountryModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI
import SwiftData

/// more later will use swiftData
@Model
final class CountryModelData {
  @Attribute(.unique) var countryCode: String
  var name: String
  var languageCode: String

  init(name: String, countryCode: String, languageCode: String) {
    self.name = name
    self.countryCode = countryCode
    self.languageCode = languageCode
  }
}
