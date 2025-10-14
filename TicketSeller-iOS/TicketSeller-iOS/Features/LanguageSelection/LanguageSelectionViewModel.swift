//
//  LanguageSelectionViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 14/10/25.
//

import SwiftUI

@Observable
final class LanguageSelectionViewModel {
  
  var languages: [LanguageModel] = []
  
  init() {
    //TODO
  }
  
  func initialState() {
    languages = LanguageModel.localSupportedLanguages()
  }
}
