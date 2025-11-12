//
//  FeatureSelection.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

struct FeatureSelectionView: View {
  @State var viewModel: FeatureSelectionViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.mainBackgroundGradient
          .ignoresSafeArea()
        
        VStack {
          ScrollView {
            LazyVGrid(columns: viewModel.columns, spacing: 16) {
              ForEach(viewModel.features, id: \.self) { feature in
                FeatureCard(viewModel: viewModel, feature: feature)
              }
            }
            .padding(.horizontal)
          }
          .fullScreenCover(item: $viewModel.featureType, content: { type in
            if type == .movies {
              MoviesView()
                .environmentObject(MoviesNavigation())
            }
            
            if type == .event {
              EventListView()
                .environmentObject(EventNavigation())
            }
            
          })
        }
        .navigationTitle("Ticket Seller")
        .navigationBarTitleDisplayMode(.inline)
        .task {
          await viewModel.fetchFeatures()
        }
      }
    }
  }
}

#Preview {
  FeatureSelectionView(viewModel: FeatureSelectionViewModel())
}
