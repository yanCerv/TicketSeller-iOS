//
//  MyPurchasesView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 04/11/25.
//

import SwiftUI

struct MyPurchasesView: View {
  @EnvironmentObject var navigation: MyPurchasesNagivation
  @State var viewMode: MyPurchasesViewModel = MyPurchasesViewModel()
  
  var body: some View {
    Text("Hello, World!")
  }
}
