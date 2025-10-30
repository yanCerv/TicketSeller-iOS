//
//  MainTabView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI

struct MainTabView: View {
  
  let selectionViewModel: FeatureSelectionViewModel = FeatureSelectionViewModel()
  let accountViewModel: AccountViewModel = AccountViewModel()
  
  var body: some View {
    TabView {
      Tab("Inicio", systemImage: "house") {
        FeatureSelectionView(viewModel: selectionViewModel)
      }
      
      Tab("Cuenta", systemImage: "person.circle") {
        AccountView(viewModel: accountViewModel)
          .environmentObject(AccountNavigation())
      }
    }
  }
}
