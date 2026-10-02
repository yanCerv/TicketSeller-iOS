//
//  Request.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

protocol Request {
  func request<T: Decodable>(with model: RequestModel) async throws -> T
}

fileprivate enum NetworkSession {
  static let shared: URLSession = {
    URLSession(configuration: .default, delegate: ClientURLSession(), delegateQueue: .main)
  }()
}

extension Request {
  
  func request<T: Decodable>(with model: RequestModel) async throws -> T {
    let keyStore = KeychainStore()
    if Paths.isRequiredValidateAccess(with: model.path) {
      try validateSessionExpired(keyStore: keyStore)
      try await validateAccessExpired(keyStore: keyStore, model: model)
      
      return try await requestData(with: model)
    }
    
    return try await requestData(with: model)
  }
  
  private func validateSessionExpired(keyStore: KeychainStore) throws {
    if keyStore.isUserLogged() {
      let isSessionExpired = Date.isAccessOrSessionExpired(using: FileDataManager.sessionExpired)
      if isSessionExpired {
        keyStore.deleteAccess()
        throw ErrorHandler.sessionExpired
      }
    } else {
      throw ErrorHandler.error(message: "You are not logged in, please login to continue in account option", statusCode: 1)
    }
  }
  
  private func validateAccessExpired(keyStore: KeychainStore, model: RequestModel) async throws {
    let refresh = try? keyStore.value(for: .refresh)
    let isAccessExpired = Date.isAccessOrSessionExpired(using: FileDataManager.accessExpired)
    
    if let refresh,
       isAccessExpired {
      let body = RefreshAccessRequest(refreshToken: refresh)
      let newModel = RequestModel(path: Paths.refresh.rawValue, method: .post, requestBody: body, provider: .host)
      do {
        let refreshToken: AccessLoginResponse = try await requestData(with: newModel)
        try keyStore.save(access: refreshToken)
      } catch {
        keyStore.deleteAccess()
        throw ErrorHandler.requestFail
      }
    }
  }
  
  //New
  private func requestData<T: Decodable>(with model: RequestModel) async throws -> T {
    let modelRequest = model.request
    let (data, response) = try await NetworkSession.shared.data(for: modelRequest)
    
    guard let result = response as? HTTPURLResponse else {
      throw ErrorHandler.requestFail
    }
    
    switch result.statusCode {
    case 200...299:
      let decode = try JSONDecoder().decode(T.self, from: data)
      return decode
    default:
      let error = try JSONDecoder().decode(ErrorResponse.self, from: data)
      throw ErrorHandler.error(message: "\(error.message) (\(error.statusCode))", statusCode: error.statusCode)
    }
  }
}
