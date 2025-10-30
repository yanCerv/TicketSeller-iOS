//
//  BackNavigation.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI

struct BackToolbarButton: ToolbarContent {
  let onTap: () -> Void
  
  var body: some ToolbarContent {
    ToolbarItem(placement: .topBarLeading) {
      Button(action: onTap) {
        Image(systemName: "rectangle.portrait.and.arrow.forward")
          .renderingMode(.template)
          .foregroundStyle(.white.opacity(0.8))
      }
    }
  }
}
