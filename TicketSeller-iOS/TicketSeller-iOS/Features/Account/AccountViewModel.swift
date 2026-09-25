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
  private let accountKey: String = FileDataManager.accountKey
  private let keyStore: KeychainStore = KeychainStore()
  
  var appCountries: [AppCountry] = []
  var isUserLoggedIn: Bool = false
  var accountUser: AccountUser!
  
  var countryFlag: String = ""
  var language: String = ""
  
  var selectedCountry: String = ""
  var selectedLanguage: String = ""
  var countryFlags: [String] = []
  var countryLanguages: [String] = []
  
  var showLoginRegister: Bool = false
  var showCountryPicker: Bool = false
  var showLanguagePicker: Bool = false
  
  //Alert
  var showAlert: Bool = false
  var message: String = ""
  
  init(client: FeatureSelectionProvider = FeatureSelectionClient()) {
    self.client = client
  }
  
  func fetchAppCountries() async {
    await validateUserLogged()
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
  
  func didTapLogout() {
    isUserLoggedIn = false
    keyStore.deleteAccess()
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
  
  private func validateUserLogged() async {
    guard keyStore.isUserLogged() else { return }
    
    if let user = try? FileDataManager.load(AccountUser.self, from: accountKey) {
      isUserLoggedIn = true
      accountUser = user
      showLoginRegister = false
    }
    
    do {
      let accountData = try await client.accountData()
      debugPrint("userIsLoged As \(accountData)")
    } catch {
      let error = error as? ErrorHandler
      let errorMessage = error?.message ?? "Unknown Error"
      showAlert = true
      message = errorMessage
    }
  }
}

extension AccountViewModel: LoginActionInput {
  
  func didGet(user: AccountUser) async {
  
    if FileDataManager.exists(fileName: accountKey) {
      try? FileDataManager.update(user, as: accountKey)
    } else {
      try? FileDataManager.save(user, as: accountKey)
    }
    
    showLoginRegister = false
    isUserLoggedIn = true
    accountUser = user
  }
}
