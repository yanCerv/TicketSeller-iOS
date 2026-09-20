//
//  MainFeaturesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import Foundation

protocol FeatureSelectionProvider {
  func fetchMainFeatures() async -> [MainFeature]
  func fetchCountries() async -> [AppCountry]
}

actor FeatureSelectionClient: Request, FeatureSelectionProvider {
  
  func fetchMainFeatures() async -> [MainFeature] {
    let resultData = ResourceJSON.from(fileName: "Features", type: MainFeatureResponseDTO.self)
    let mainFeatures = resultData.result
    
    return mainFeatures
  }
  
  func fetchCountries() async -> [AppCountry] {
    let resultData = ResourceJSON.from(fileName: "AppCountries", type: AppCountryResponseDTO.self)
    let countries = resultData.result
 
    return countries
  }
}
