//
//  PreferencesViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 02/10/26.
//

import SwiftUI

@Observable
final class PreferencesViewModel {
  private let client: AccountProvider
  
  init(client: AccountProvider = AccountClient()) {
    self.client = client
  }
  
  func getUserFavorites() async {
   
  }
}
