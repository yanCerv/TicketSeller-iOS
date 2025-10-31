//
//  LoginRegisterViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI

@Observable
final class LoginRegisterViewModel {
  
  var selectedMode: AuthMode = .login
  
  var accountName: String = ""
  var otpCode: String = ""
  var sendedAccount: Bool = false
  var isLoading: Bool = false
  
  var accountNameValid: Bool {
    return accountName.count >= 4
  }
  
  var otpCodeFilled: Bool {
    return otpCode.count == 6
  }
  
  
  init() {
    
  }
  
  func didtapLogin() {
    sendedAccount = true
    
    if otpCodeFilled {
      didVerifiedOTP()
    }
  }
  
  private func didVerifiedOTP() {
    isLoading = true
  }
}
