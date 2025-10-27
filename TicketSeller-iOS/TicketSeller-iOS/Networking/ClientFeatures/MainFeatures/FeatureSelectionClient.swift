//
//  MainFeaturesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import Foundation

protocol FeatureSelectionProvider {
  func fetchMainFeatures() async -> [MainFeature]
}

actor FeatureSelectionClient: Request, FeatureSelectionProvider {
  
  func fetchMainFeatures() async -> [MainFeature] {
    let result = ResourceJSON.from(fileName: "Features", type: MainFeatureResponseDTO.self)
    let mainFeatures = result.result
    
    return mainFeatures
  }
}
