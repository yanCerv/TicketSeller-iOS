//
//  ButtonModifier.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
  
  @Binding var isEnabled: Bool
  var maxWidth: CGFloat
  var font: Font = Font.system(size: 16, weight: .semibold)
  
  private var mainColor: Color {
    return isEnabled ? Color.blue : Color.gray.opacity(0.5)
  }
  
  //MARK: Body
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: maxWidth, maxHeight: 45)
      .font(font)
      .foregroundColor(Color.white)
      .background(mainColor)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(.clear, lineWidth: 0.5)
      )
      .disabled(!isEnabled)
  }
}
