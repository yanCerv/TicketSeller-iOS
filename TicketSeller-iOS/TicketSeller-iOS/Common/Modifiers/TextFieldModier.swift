//
//  TextFieldModier.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI

struct LoginTextFieldModifier: ViewModifier {
  let enabled: Bool
  
  func body(content: Content) -> some View {
    content
      .frame(height: 30)
      .padding(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(enabled ? Color.green : Color.gray.opacity(0.4), lineWidth: 1)
      )
      .padding(.bottom, 16)
  }
}

extension View {
  func loginTextFieldStyle(enabled: Bool) -> some View {
    self.modifier(LoginTextFieldModifier(enabled: enabled))
  }
}

