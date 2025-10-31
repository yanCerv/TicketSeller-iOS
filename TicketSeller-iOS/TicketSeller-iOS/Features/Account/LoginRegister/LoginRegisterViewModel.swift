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
  
  var selectedMode: AuthMode = .login
  
  var accountName: String = ""
  var otpCode: String = ""
  var sendedAccount: Bool = false
  var isLoading: Bool = false
  
  var accountUser: AccountUser?
  
  var accountNameValid: Bool {
    return accountName.count >= 4
  }
  
  var otpCodeFilled: Bool {
    return otpCode.count == 6
  }
  
  //MARK: - Init
  
  init(client: AccountProvider = AccountClient(), input: LoginActionInput? = nil) {
    self.client = client
    self.input = input
  }
  
  //MARK: - Methods
  
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
      input?.didGet(user: accountUser)
    }
  }
}
