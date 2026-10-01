//
//  LoginRegisterViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI
import GoogleSignInSwift

@Observable
final class LoginRegisterViewModel {

  private let keyStore: KeychainStore = KeychainStore()
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
  var loadingMessage: String = ""
  var sendedAccount: Bool = false
  var isLoading: Bool = false
  var isUserCreated: Bool = false
  
  var showAlet: Bool = false
  var errorMessage: String = ""
  
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
  
  func didTapRegisterNative() async {
    isLoading = true
    do {
      let register = try await client.register(email: accountName, password: password)
      isUserCreated = register.isActive
      accountName = ""
      password = ""
      debugPrint("Register Success and isActive = \(register.isActive).  Please login ")
      //SHOW ALERT!
    } catch {
      if let error = error as? ErrorHandler {
        showAlet = true
        errorMessage = error.message
      }
    }
  }
  
  func didTapLoginRegisterWith(with type: RegistrationType) async {
    isLoading = true
    do {
      switch type {
      case .google:
        let credential = try await GoogleSignInClient.credential()
        await auth(with: credential)
      case .apple:
        let credential = try await GoogleSignInClient.credential()
        await auth(with: credential)
      case .native:
        await didTapLoginButton()
      }
    } catch {
      showAlet = true
      if let error = error as? ErrorHandler {
        errorMessage = error.message
      } else {
        errorMessage = "No fue posible iniciar sesión con Google."
      }
    }
  }
  
  func auth(with credential: SocialCredential) async {
    do {
      let loginAccount = try await client.authenticate(with: credential)
      try keyStore.save(access: loginAccount)
      await getProfile()
    } catch {
      isLoading = false
      if let error = error as? ErrorHandler {
        errorMessage = error.message
      }
    }
  }
  
  func didTapLoginButton() async { // Old login with password
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
  
  //login passwordless

  func didSendMailOTP() {
    sendedAccount = true
    isLoading = true
    Task {
      do {
        let loginCode = try await client.requestLoginCode(email: accountName)
        isLoading = false
        loadingMessage = loginCode.message
      } catch {
        if let error = error as? ErrorHandler {
          showAlet = true
          errorMessage = error.message
        }
      }
    }
  }
  
  func didtapLogin() {
    isLoading = true
    sendedAccount = false
    Task {
      do {
        let otp = try await client.verifyLoginCode(email: accountName, otp: otpCode)
        try keyStore.save(access: otp)
        await getProfile()
      } catch {
        if let error = error as? ErrorHandler {
          isLoading = false
          showAlet = true
          errorMessage = error.message
        }
      }
    }
  }
  
  //MARK: - Private Methods
  
  private func getProfile() async {
    do {
      let accountResponse = try await client.fetchUserProfile()
      if let userProfile = accountResponse.dataProfile() {
        await input?.didGet(user: userProfile)
      } else {
        showAlet = true
        errorMessage = "User Credentials not founded please try again."
      }
    } catch {
      if let error = error as? ErrorHandler {
        showAlet = true
        errorMessage = error.message
      }
    }
    isLoading = false
  }
}
