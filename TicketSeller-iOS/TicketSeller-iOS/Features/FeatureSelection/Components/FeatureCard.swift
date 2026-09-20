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
      VStack(spacing: 8) {
        AsyncImage(url: URL(string: feature.imageUrl)) { image in
          image
            .resizable()
            .scaledToFill()
        } placeholder: {
          Color.gray.opacity(0.2)
        }
        .clipped()

        Text(feature.title)
          .font(.system(size: 16, weight: .semibold))
          .foregroundStyle(.primary)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 8)
      }
      .frame(width: 160, height: 140)
    }
    .buttonStyle(FeatureCardButtonStyle(isActive: feature.isActive))
    .disabled(!feature.isActive)
  }
}
