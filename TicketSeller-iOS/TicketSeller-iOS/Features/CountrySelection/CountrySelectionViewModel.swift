//
//  CountrySelectionViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 14/10/25.
//

import SwiftUI

@Observable
final class CountrySelectionViewModel {
  
  private let client: FeatureSelectionProvider
  
  var countries: [AppCountry] = []
  
  init(client: FeatureSelectionProvider = FeatureSelectionClient()) {
    self.client = client
  }
  
  func fetchCountries() async {
    let countries = await client.fetchCountries()
    self.countries = countries
  }
}
