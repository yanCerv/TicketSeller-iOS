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
      Text("Hello, World!")
    }
  }
}

#Preview {
  RegisterForm(viewModel: LoginRegisterViewModel())
}
