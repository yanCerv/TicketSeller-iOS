//
//  AccountViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI

@Observable
final class AccountViewModel {
  private let client: FeatureSelectionProvider
  
  var appCountries: [AppCountry] = []
  var isUserLoggedIn: Bool = false
  
  var countryFlag: String = ""
  var language: String = ""
  
  var selectedCountry: String = ""
  var selectedLanguage: String = ""
  var countryFlags: [String] = []
  var countryLanguages: [String] = []
  
  var showLoginRegister: Bool = false
  var showCountryPicker: Bool = false
  var showLanguagePicker: Bool = false
  
  init(client: FeatureSelectionProvider = FeatureSelectionClient()) {
    self.client = client
  }
  
  func fetchAppCountries() async {
    let appCountries = await client.fetchCountries()
    self.appCountries = appCountries
    
    verifyCountry(from: appCountries)
    let flags = appCountries.map(\.securedFlag)
    let languages = appCountries.map(\.languageCode)
    countryFlags = flags
    countryLanguages = languages
  }
  
  func didTapPickerCountry() {
    showCountryPicker = true
  }
  
  func didTapPickerLanguage() {
    showLanguagePicker = true
  }
  
  func didTapLoginRegister() {
    showLoginRegister = true
  }
  
  private func verifyCountry(from appCountries: [AppCountry]) {
    if !FileDataManager.exists(fileName: "country"),
      let countryDetected = LocaleManager.detectedCountryModel(from: appCountries) {
      try? FileDataManager.save(countryDetected, as: "country")
      countryFlag = countryDetected.securedFlag
      language = countryDetected.languageCode
    } else {
      do {
        let saved = try FileDataManager.load(AppCountry.self, from: "country")
        countryFlag = saved.securedFlag
        language = saved.languageCode
      } catch {
        debugPrint("Failed to load saved country: \(error)")
      }
    }
  }
}

