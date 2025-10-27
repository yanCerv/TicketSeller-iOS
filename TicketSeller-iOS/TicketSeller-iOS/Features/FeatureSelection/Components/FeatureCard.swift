//
//  FeatureCard.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

struct FeatureCard: View {
  
  @State var viewModel: FeatureSelectionViewModel
  var feature: MainFeature
  
  init(viewModel: FeatureSelectionViewModel, feature: MainFeature) {
    self.feature = feature
    self.viewModel = viewModel
  }
  
  var body: some View {
    Button {
      viewModel.didSelect(feature)
    } label: {
      VStack {
        Text(feature.title)
          .font(.system(size: 16, weight: .semibold))
          .foregroundStyle(.primary)
          .padding()
          .frame(maxWidth: .infinity, alignment: .center)
      }
    }
    .frame(maxWidth: 180, maxHeight: 220)
    .background(.primary.opacity(0.1))
    .clipShape(RoundedRectangle(cornerRadius: 6))
    .padding()
  }
}

