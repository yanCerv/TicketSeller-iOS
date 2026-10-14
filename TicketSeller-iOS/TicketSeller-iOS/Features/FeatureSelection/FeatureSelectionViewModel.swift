//
//  FeatureSelectionViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

@Observable
final class FeatureSelectionViewModel {
  
  private let client: FeatureSelectionProvider
  
  private(set) var features: [MainFeature] = []
  private(set) var isUserLoggedIn: Bool = false
  
  private var isLoaded: Bool = false
  
  var featureType: FeatureType? = nil
  var isLoading: Bool = false
  var showAlert: Bool = false
  var message: String = ""

  init(client: FeatureSelectionProvider = FeatureSelectionClient()) {
    self.client = client
  }
  
  func fetchFeatures() async {
    guard !isLoaded else { return }
    isLoading = true
    
    do {
      let response = try await client.fetchMainFeatures()
      self.features = response.result
      isLoading = false
      isLoaded = true
    } catch {
      if let error = error as? ErrorHandler {
        showAlert = true
        isLoading = false
        message = error.message
      }
    }
  }
  
  func didSelect(_ feature: MainFeature) {
    featureType = feature.featureType
  }
}
