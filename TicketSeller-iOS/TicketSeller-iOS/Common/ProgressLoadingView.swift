//
//  ProgressLoadingView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

import SwiftUI

struct ProgressLoadingView: View {
  
  var typeLoading: TypeLoadgin = .movies
  var text: String
  
  private var color: Color {
    switch typeLoading {
    case .movies:
      return .brown.opacity(0.8)
    case .events:
      return .red.opacity(0.8)
    }
  }
  
  init(typeLoading: TypeLoadgin, text: String) {
    self.typeLoading = typeLoading
    self.text = text
  }
  
  var body: some View {
    
    ProgressView(text)
      .padding(.all, 46)
      .progressViewStyle(.circular)
      .background(color)
      .foregroundStyle(.primary)
      .clipShape(RoundedRectangle(cornerRadius: 6))
      .overlay {
        RoundedRectangle(cornerRadius: 6)
          .stroke(.clear)
      }
  }
  
  enum TypeLoadgin {
    case movies
    case events
  }
}
