//
//  NavigationButton.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 08/11/25.
//

import SwiftUI

struct NavigationButton: ToolbarContent {
  
  let systemImage: String
  let placement: ToolbarItemPlacement
  let onTap: () -> Void
  
  var body: some ToolbarContent {
    ToolbarItem(placement: placement) {
      Button(action: onTap) {
        Image(systemName: systemImage)
          .renderingMode(.template)
          .foregroundStyle(.white.opacity(0.8))
      }
    }
  }
}
