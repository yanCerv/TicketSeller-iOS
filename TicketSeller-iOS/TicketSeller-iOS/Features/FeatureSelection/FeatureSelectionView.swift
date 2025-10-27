//
//  FeatureSelection.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

struct FeatureSelectionView: View {
  
  @State var viewModel: FeatureSelectionViewModel = FeatureSelectionViewModel()
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: viewModel.columns) {
        ForEach(viewModel.features, id: \.self) { feature in
          FeatureCard(viewModel: viewModel, feature: feature)
        }
      }
      .task {
        await viewModel.fetchFeatures()
      }
    }
    .fullScreenCover(item: $viewModel.featureType, content: { type in
      if type == .movies {
        MoviesTabView()
      }
    })
  }
}

#Preview {
  FeatureSelectionView()
}
