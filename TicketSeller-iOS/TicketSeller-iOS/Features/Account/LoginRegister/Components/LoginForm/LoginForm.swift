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
      HStack {
        TextField("Email account", text: $viewModel.accountName)
          .loginTextFieldStyle(enabled: viewModel.accountNameValid)
          .keyboardType(.emailAddress)
          .textContentType(.emailAddress)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
          .disabled(viewModel.isLoading)
        
//        Button("Send OTP") {
//           
//        }
//        .modifier(ButtonModifier(isEnabled: viewModel.accountNameValid))
//        .disabled(viewModel.isLoading)
        
        Button("", systemImage: "paperplane.fill") {
          viewModel.didSendMailOTP()
        }
        .modifier(ButtonCircleWithImage(isEnabled: viewModel.accountNameValid))
        .padding(.bottom, 16)
      }
      
      if viewModel.sendedAccount { // For Next Feature is pending
        TextField("Received email code", text: $viewModel.otpCode)
          .loginTextFieldStyle(enabled: viewModel.otpCodeFilled)
          .keyboardType(.numberPad)
          .autocorrectionDisabled()
          .disabled(viewModel.isLoading)
      }
      
      Button(viewModel.sendedAccount ? "Continue" : "Login") {
         viewModel.didtapLogin()
      }
      .modifier(ButtonModifier(isEnabled: viewModel.otpCodeFilled))
      .disabled(viewModel.isLoading)
    }
    .padding(.horizontal, 26)
  }
}

#Preview {
  LoginForm(viewModel: LoginRegisterViewModel())
}
