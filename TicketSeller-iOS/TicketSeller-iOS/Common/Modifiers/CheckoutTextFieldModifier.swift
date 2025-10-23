//
//  CheckoutTextFieldModifier.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

import SwiftUI

struct CheckoutTextFieldModifier: ViewModifier {
  var isValid: Bool
  var maxLength: Int = 16
  var contentType: UITextContentType = .familyName
  var autocapitalization: TextInputAutocapitalization = .words
  
  func body(content: Content) -> some View {
    content
      .textContentType(.familyName)
      .textInputAutocapitalization(autocapitalization)
      .padding(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(isValid ? Color.green : Color.gray.opacity(0.4), lineWidth: 2)
      )
  }
}
