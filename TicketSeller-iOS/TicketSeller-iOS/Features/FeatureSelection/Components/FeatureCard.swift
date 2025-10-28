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
            .overlay(feature.isActive ? nil : Color.black.opacity(0.6))
        } placeholder: {
          Color.gray.opacity(0.2)
        }
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .clipped()
        .cornerRadius(8)

        Text(feature.title)
          .font(.system(size: 16, weight: .semibold))
          .foregroundStyle(.primary)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 8)
      }
    }
    .buttonStyle(FeatureCardButtonStyle())
    .frame(maxWidth: 180, maxHeight: 220)
    .foregroundStyle(feature.isActive ? Color.black : Color.white)
    .background(feature.isActive ? Color.yellow.opacity(0.15) : Color.gray.opacity(0.5))
    .clipShape(RoundedRectangle(cornerRadius: 6))
    .padding()
    .disabled(!feature.isActive)
  }
}

struct FeatureCardButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
      .opacity(configuration.isPressed ? 0.85 : 1.0)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}
