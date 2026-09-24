//
//  LoginRegisterViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI

@Observable
final class LoginRegisterViewModel {
  
  private let client: AccountProvider
  weak var input: LoginActionInput!
  
  var selectedMode: AuthMode = .login {
    didSet {
      password = ""
      accountName = ""
    }
  }
  
  var accountName: String = ""
  var password: String = ""
  var otpCode: String = ""
  var sendedAccount: Bool = false
  var isLoading: Bool = false
  var isUserCreated: Bool = false
  var accountUser: AccountUser?
  
  var accountNameValid: Bool {
    return accountName.count >= 4
  }
  
  var otpCodeFilled: Bool {
    return otpCode.count == 6
  }
  
  var showRegisterButton: Bool {
    return accountNameValid && password.count >= 8
  }
  
  //MARK: - Init
  
  init(client: AccountProvider = AccountClient(), input: LoginActionInput? = nil) {
    self.client = client
    self.input = input
  }
  
  //MARK: - Methods
  
  func didTapRegister() async {
    isLoading = true
    
    do {
      let register = try await client.register(email: accountName, password: password)
      isUserCreated = register.isActive
      accountName = ""
      password = ""
      debugPrint("Register Success and isActive = \(register.isActive).  Please login ")
      //SHOW ALERT!
    } catch {
      debugPrint(error)
    }
  }
  
  func didTapLoginButton() async {
    isLoading = true
    
    do {
      let loginAccount = try await client.login(email: accountName, password: password)
      let keyChain = KeychainStore()
      try keyChain.save(access: loginAccount)
      isLoading = false
    } catch {
      isLoading = false
      debugPrint(error)
    }
  }
  
  //For The next Feature Pending
  func didtapLogin() {
    sendedAccount = true
    
    Task {
      if otpCodeFilled {
        await didVerifiedOTP()
      }
    }
  }
  
  //MARK: - Private Methods
  
  private func didVerifiedOTP() async {
    isLoading = true
    
    try? await Task.sleep(nanoseconds: 3_000_000_000)
    
    let dataUser = await client.fetchAccountUser()
    accountUser = dataUser
    
    if let accountUser {
      isLoading = false
      await input?.didGet(user: accountUser)
    }
  }
}
