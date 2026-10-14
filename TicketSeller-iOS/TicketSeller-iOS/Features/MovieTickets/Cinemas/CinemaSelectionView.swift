//
//  CinemaSelectionView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 14/10/26.
//

import SwiftUI

struct CinemaSelectionView: View {
  
  @State private var viewModel: CinemaSelectionViewModel
  
  init(viewModel: CinemaSelectionViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      Text("Cinema Selection")
    }
  }
}
