//
//  FeatureSelection.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

struct FeatureSelectionView: View {
  @EnvironmentObject var navigation: FeatureNavigation
  @State var viewModel: FeatureSelectionViewModel = FeatureSelectionViewModel()
  
  var body: some View {
    NavigationStack(path: $navigation.paths) {
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
          })
          
          Divider()
            .background(Color.ticketDivider)
            .padding()

          if viewModel.isUserLoggedIn {
            
          } else {
            Button {
              
            } label: {
              Text("Login or register")
                .frame(maxWidth: .infinity, maxHeight: 50)
                .font(.system(.headline, weight: .semibold))
                .foregroundColor(Color.ticketPrimaryText)
                .background(Color.ticketPrimaryButton)
                .cornerRadius(10)
                .padding(.horizontal)
            }
          }
        }
        .navigationTitle("Ticket Seller")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.clear, for: .navigationBar)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
          await viewModel.fetchFeatures()
        }
      }
    }
  }
}

#Preview {
  FeatureSelectionView()
}
