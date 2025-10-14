//
//  LanguageSelectionView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 14/10/25.
//

import SwiftUI

struct LanguageSelectionView: View {
  
  @State var viewModel: LanguageSelectionViewModel = LanguageSelectionViewModel()
  
  var body: some View {
    VStack {
      Text("View")
        .task {
          viewModel.initialState()
        }
    }
  }
}

#Preview {
  LanguageSelectionView(viewModel: LanguageSelectionViewModel())
}
