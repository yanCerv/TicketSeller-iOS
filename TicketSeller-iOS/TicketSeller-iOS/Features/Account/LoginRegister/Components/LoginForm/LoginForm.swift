//
//  LoginForm.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI

struct LoginForm: View {
  
  @State var viewModel: LoginRegisterViewModel
  
  var body: some View {
    VStack {
      TextField("Email account", text: $viewModel.accountName)
        .loginTextFieldStyle(enabled: viewModel.accountNameValid)
        .keyboardType(.emailAddress)
        .textContentType(.emailAddress)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .disabled(viewModel.isLoading)
      
      SecureField("Password", text: $viewModel.password)
        .loginTextFieldStyle(enabled: viewModel.accountNameValid)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .disabled(viewModel.isLoading)
      
      
      if viewModel.sendedAccount { // For Next Feature is pending
        TextField("OTP", text: $viewModel.otpCode)
          .loginTextFieldStyle(enabled: viewModel.otpCodeFilled)
          .keyboardType(.numberPad)
          .autocorrectionDisabled()
          .disabled(viewModel.isLoading)
      }
      
      Button(viewModel.sendedAccount ? "Continue" : "Login") {
        Task {
          await viewModel.didTapLoginButton()
        }
      }
      .modifier(ButtonModifier(isEnabled: viewModel.showRegisterButton))
      .disabled(viewModel.isLoading)
      
//      Button(viewModel.sendedAccount ? "Continue" : "Login") {
//         viewModel.didtapLogin()
//      }
//      .modifier(ButtonModifier(isEnabled: viewModel.accountNameValid))
//      .disabled(viewModel.isLoading)
    }
    .padding(.horizontal, 26)
  }
}

#Preview {
  LoginForm(viewModel: LoginRegisterViewModel())
}
