//
//  MainFeaturesClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import Foundation

protocol FeatureSelectionProvider: AccountProvider {
  func fetchMainFeatures() async throws -> MainFeatureResponseDTO
  func fetchCountries() async -> [AppCountry]
}

actor FeatureSelectionClient: Request, FeatureSelectionProvider {
  
  func fetchMainFeatures() async throws -> MainFeatureResponseDTO {
    let path = Paths.appFeatures.rawValue
    let requestModel = await RequestModel(path: path, isAuthorized: false)

    return try await request(with: requestModel)
  }
  
  @MainActor
  func fetchCountries() async -> [AppCountry] {
    let resultData = ResourceJSON.from(fileName: "AppCountries", type: AppCountryResponseDTO.self)
    let countries = resultData.result
 
    return countries
  }
  
  func fetchUserProfile() async throws -> AccessUserResponse {
    let path = Paths.account
    let requestModel = await RequestModel(path: path.rawValue, cachePolicy: .reloadIgnoringLocalCacheData)
    
    return try await request(with: requestModel)
  }
  
  func logout() async throws -> LogoutResponse {
    let path = Paths.logout
    let keyStore = KeychainStore()
    let refreshToken = await keyStore.getRefreshToken()
    let body = RefreshAccessRequest(refreshToken: refreshToken)
    let requestModel = await RequestModel(path: path.rawValue, method: .post, requestBody: body, provider: .host,isAuthorized: false)
    
    return try await request(with: requestModel)
  }
}
