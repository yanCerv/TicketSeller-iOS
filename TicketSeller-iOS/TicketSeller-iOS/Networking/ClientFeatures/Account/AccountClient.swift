//
//  AccountClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import Foundation

protocol AccountProvider: Request {
  //Register - login - loguot
  func register(email: String, password: String) async throws -> AccessUserResponse
  func login(email: String, password: String) async throws -> AccessLoginResponse
  func logout() async throws -> LogoutResponse
  // Otp auth
  func authenticate(with credential: SocialCredential) async throws -> AccessLoginResponse
  func requestLoginCode(email: String) async throws -> LoginOTPRequestResponse
  func verifyLoginCode(email: String, otp: String) async throws -> AccessLoginResponse
  // Data User
  func fetchUserProfile() async throws -> AccessUserResponse
  func addFavorite(movieId: Int) async throws -> AddFavoriteMovieResponse
  func fetchFavoriteMovies() async throws -> [AddFavoriteMovieResponse]
  func deleteFavorite(movieId: Int) async throws -> [AddFavoriteMovieResponse]
}

//Non Required methods external
extension AccountProvider {
  func register(email: String, password: String) async throws -> AccessUserResponse { .emptyValues() }
  func login(email: String, password: String) async throws -> AccessLoginResponse { .emptyValues() }
  
  func logout() async throws -> LogoutResponse {
    let path = Paths.logout
    let keyStore = KeychainStore()
    let refreshToken = keyStore.getRefreshToken()
    let body = RefreshAccessRequest(refreshToken: refreshToken)
    let requestModel = RequestModel(path: path.rawValue, requestBody: body)
    
    return try await request(with: requestModel)
  }
  
  func authenticate(with credential: SocialCredential) async throws -> AccessLoginResponse { .emptyValues() }
  func requestLoginCode(email: String) async throws -> LoginOTPRequestResponse { LoginOTPRequestResponse(message: "") }
  func verifyLoginCode(email: String, otp: String) async throws -> AccessLoginResponse { .emptyValues() }
  
  func fetchUserProfile() async throws -> AccessUserResponse {
    let path = Paths.account
    let requestModel = RequestModel(path: path.rawValue,provider: .host, cachePolicy: .reloadIgnoringLocalCacheData)
    
    return try await request(with: requestModel)
  }
  
  func addFavorite(movieId: Int) async throws -> AddFavoriteMovieResponse {
    let path = "\(Paths.addFavorite.rawValue)\(movieId)"
    let requestModel = RequestModel(path: path, method: .post)
    
    return try await request(with: requestModel)
  }
  
  func fetchFavoriteMovies() async throws -> [AddFavoriteMovieResponse]  {
    let path = Paths.modifyFavorite
    let requestModel = RequestModel(path: path.rawValue)
    
    return try await request(with: requestModel)
  }
  
  func deleteFavorite(movieId: Int) async throws -> [AddFavoriteMovieResponse] {
    let path = "\(Paths.addFavorite)\(movieId)"
    let requestModel = RequestModel(path: path, method: .delete)
    
    return try await request(with: requestModel)
  }
}

actor AccountClient: AccountProvider {
  
  // Only services will not shared with other feature Here
  
  func register(email: String, password: String) async throws -> AccessUserResponse {
    let path = Paths.register
    let body = UserAccountRequest(email: email, password: password)
    let requestModel = await RequestModel(path: path.rawValue, method: .post, requestBody: body, provider: .host)
    
    return try await request(with: requestModel)
  }
  
  func login(email: String, password: String) async throws -> AccessLoginResponse {
    let path = Paths.login
    let body = UserAccountRequest(email: email, password: password)
    let requestModel = await RequestModel(path: path.rawValue, method: .post, requestBody: body, provider: .host)
    
    return try await request(with: requestModel)
  }
  
  
  func authenticate(with credential: SocialCredential) async throws -> AccessLoginResponse {
    let requestModel =  await RequestModel(path: Paths.google.rawValue,
                                           method: .post,
                                           requestBody: credential,
                                           isAuthorized: false)
    
    return try await request(with: requestModel)
  }
  
  
  func requestLoginCode(email: String) async throws -> LoginOTPRequestResponse {
    let body = RequestLoginOTP(email: email)
    let requestModel = await RequestModel(path: Paths.requestLoginCode.rawValue,
                                    method: .post,
                                    requestBody: body,
                                    isAuthorized: false)
    
    return try await request(with: requestModel)
  }
  
  func verifyLoginCode(email: String, otp: String) async throws -> AccessLoginResponse {
    let body = VerifyLoginOTP(email: email, otp: otp)
    let requestModel = await RequestModel(path: Paths.verifyLoginCode.rawValue,
                                    method: .post,
                                    requestBody: body,
                                    isAuthorized: false)
    
    return try await request(with: requestModel)
  }
}
