//
//  AccountClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//



protocol AccountProvider {
  func fetchAccountUser() async -> UserProfile
  func register(email: String, password: String) async throws -> AccessUserResponse
  func authenticate(with credential: SocialCredential) async throws -> AccessLoginResponse
  func login(email: String, password: String) async throws -> AccessLoginResponse
  func requestLoginCode(email: String) async throws -> LoginOTPRequestResponse
  func verifyLoginCode(email: String, otp: String) async throws -> AccessLoginResponse
  func logout() async throws -> LogoutResponse
  func accountData() async throws -> AccessUserResponse
}

//Non Required methods external
extension AccountProvider {
  func fetchAccountUser() async -> UserProfile { .emptyValues() }
  func register(email: String, password: String) async throws -> AccessUserResponse { .emptyValues() }
  func authenticate(with credential: SocialCredential) async throws -> AccessLoginResponse { .emptyValues() }
  func login(email: String, password: String) async throws -> AccessLoginResponse { .emptyValues() }
  func requestLoginCode(email: String) async throws -> LoginOTPRequestResponse { LoginOTPRequestResponse(message: "") }
  func verifyLoginCode(email: String, otp: String) async throws -> AccessLoginResponse { .emptyValues() }
  func logout() async throws -> LogoutResponse { LogoutResponse(success: false) }
  func accountData() async throws -> AccessUserResponse { .emptyValues() }
}

actor AccountClient: Request, AccountProvider {

  @MainActor
  func fetchAccountUser() async -> UserProfile {
    let response = ResourceJSON.from(fileName: "AccountUser", type: AccountUserResponseDTO.self)
    let dataUser = response.result
    
    return dataUser
  }

  
  func register(email: String, password: String) async throws -> AccessUserResponse {
    let path = Paths.register
    let body = UserAccountRequest(email: email, password: password)
    let requestModel = await RequestModel(path: path.rawValue, method: .post, requestBody: body, provider: .host)
    
    return try await request(with: requestModel)
  }
  
  func authenticate(with credential: SocialCredential) async throws -> AccessLoginResponse {
    let requestModel = await RequestModel(
      path: Paths.google.rawValue,
      method: .post,
      requestBody: credential,
      provider: .host,
      isAuthorized: false
    )
    return try await request(with: requestModel)
  }

  func login(email: String, password: String) async throws -> AccessLoginResponse {
    let path = Paths.login
    let body = UserAccountRequest(email: email, password: password)
    let requestModel = await RequestModel(path: path.rawValue, method: .post, requestBody: body, provider: .host)
    
    return try await request(with: requestModel)
  }

  func requestLoginCode(email: String) async throws -> LoginOTPRequestResponse {
    let body = RequestLoginOTP(email: email)
    let requestModel = await RequestModel(
      path: Paths.requestLoginCode.rawValue,
      method: .post,
      requestBody: body,
      provider: .host,
      isAuthorized: false
    )

    return try await request(with: requestModel)
  }

  func verifyLoginCode(email: String, otp: String) async throws -> AccessLoginResponse {
    let body = VerifyLoginOTP(email: email, otp: otp)
    let requestModel = await RequestModel(
      path: Paths.verifyLoginCode.rawValue,
      method: .post,
      requestBody: body,
      provider: .host,
      isAuthorized: false
    )

    return try await request(with: requestModel)
  }
}
