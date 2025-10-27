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
  private(set) var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
  private var isLoaded: Bool = false
  private var isLoading: Bool = false
  
  var featureType: FeatureType? = nil

  init(client: FeatureSelectionProvider = FeatureSelectionClient()) {
    self.client = client
  }
  
  func fetchFeatures() async {
    guard !isLoaded else { return }
    
    let features = await client.fetchMainFeatures()
    
    self.features = features
  }
  
  func didSelect(_ feature: MainFeature) {
    featureType = feature.featureType
  }
}
