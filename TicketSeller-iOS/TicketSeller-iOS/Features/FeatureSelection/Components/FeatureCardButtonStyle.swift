//
//  FeatureCardButtonStyle.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 28/10/25.
//

import SwiftUI

struct FeatureCardButtonStyle: ButtonStyle {
  
  var isActive: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(isActive ? Color.yellow.opacity(0.15) : Color.gray.opacity(0.5))
      .foregroundStyle(isActive ? Color.black : Color.gray.opacity(0.5))
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
      .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
      .opacity(configuration.isPressed ? 0.85 : 1.0)
      .clipShape(RoundedRectangle(cornerRadius: 6))
      .overlay {
        RoundedRectangle(cornerRadius: 6)
          .stroke(Color.gray.opacity(0.5))
      }
  }
}
