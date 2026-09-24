//
//  AccountClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//


protocol AccountProvider {
  func fetchAccountUser() async -> AccountUser
  func register(email: String, password: String) async throws -> AccessUserResponse
  func login(email: String, password: String) async throws -> AccessLoginResponse
  func logout() async throws -> LogoutResponse
  func accountData() async throws -> AccessUserResponse
}

//Non Required methods external
extension AccountProvider {
  func fetchAccountUser() async -> AccountUser { .emptyValues() }
  func register(email: String, password: String) async throws -> AccessUserResponse { .emptyValues() }
  func login(email: String, password: String) async throws -> AccessLoginResponse { .emptyValues() }
  func logout() -> LogoutResponse { LogoutResponse(success: false) }
  func accountData() async throws -> AccessUserResponse { .emptyValues() }
}

actor AccountClient: Request, AccountProvider {
  
  @MainActor
  func fetchAccountUser() async -> AccountUser {
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
  
  func login(email: String, password: String) async throws -> AccessLoginResponse {
    let path = Paths.login
    let body = UserAccountRequest(email: email, password: password)
    let requestModel = await RequestModel(path: path.rawValue, method: .post, requestBody: body, provider: .host)
    
    return try await request(with: requestModel)
  }
}
