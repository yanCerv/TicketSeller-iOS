//
//  SeatContent.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 21/10/25.
//

import SwiftUI

struct SeatContent: View {
  
  @State var viewModel: SeatSelectionViewModel
  @State var isZooming: Bool = false
  @State var scale: CGFloat = 0.4
  
  var body: some View {
    ScrollView([.horizontal, .vertical]) {
      ZoomResizableView(isZooming: $isZooming, scale: $scale) {
        VStack(alignment: .leading) {
          ForEach(viewModel.rows, id: \.self) { row in
            LazyVGrid(columns: viewModel.columns, spacing: 8) {
              ForEach((0..<viewModel.numberOfColumns), id: \.self) { columnIndex in
                if let seat = row.seats.first(where: { $0.position.columnIndex == columnIndex }) {
                  SeatButton(seat: seat) { (seatSelected, isSelected) in
                    viewModel.didSelect(rowName: row.rowName, seat: seatSelected, isSelected: isSelected)
                  }
                  .frame(width: seat.seatWidth, height: seat.seatHeight)
                } else {
                  Color.clear.frame(width: 40, height: 40)
                }
              }
            }
          }
        }
      }.padding(.top, 10)
    }
  }
}
