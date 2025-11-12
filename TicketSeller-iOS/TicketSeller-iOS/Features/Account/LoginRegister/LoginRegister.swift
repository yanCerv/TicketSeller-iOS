//
//  LoginRegister.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI

struct LoginRegister: View {
  @State var viewModel: LoginRegisterViewModel

  var body: some View {
    VStack {
      Picker("Selecciona", selection: $viewModel.selectedMode) {
        ForEach(AuthMode.allCases, id: \.self) { mode in
          Text(mode.title)
            .tag(mode)
        }
      }
      .pickerStyle(.segmented)
      .background(Color.clear)
      .foregroundStyle(Color.mainColor)
      .padding(.horizontal, 56)
      .padding(.vertical, 26)
      .disabled(viewModel.isLoading)
      
      if viewModel.selectedMode == .login {
        LoginForm(viewModel: viewModel)
      } else {
        RegisterForm(viewModel: viewModel)
      }
      
      Spacer()
    }
    .overlay {
      if viewModel.isLoading {
        ProgressLoadingView(typeLoading: .events, text: "Verificando OTP")
      }
    }
  }
}

#Preview {
  LoginRegister(viewModel: LoginRegisterViewModel())
}
