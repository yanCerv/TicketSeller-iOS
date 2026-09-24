//
//  RegisterForm.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI

struct RegisterForm: View {
  
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
      
      if viewModel.showRegisterButton {
        Button(viewModel.sendedAccount ? "Continue" : "Login") {
          Task {
            await viewModel.didTapRegister()
          }
        }
        .modifier(ButtonModifier(isEnabled: viewModel.accountNameValid))
        .disabled(viewModel.isLoading)
      }
      
      if viewModel.isUserCreated {
        Text("User Created Successfully please login!")
        Text("Use Your Credentials!")
      }
    }
    .padding(.horizontal, 26)
  }
}

#Preview {
  RegisterForm(viewModel: LoginRegisterViewModel())
}
