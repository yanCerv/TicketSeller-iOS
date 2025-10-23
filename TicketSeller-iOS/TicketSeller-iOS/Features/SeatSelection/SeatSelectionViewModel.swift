//
//  SeatSelectionViewModel.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

@Observable
final class SeatSelectionViewModel {
  
  private let client: MoviesProvider
  
  let dataPurchase: DataPurchase
  let columns: [GridItem]
  
  let numberOfColumns: Int = 20

  var movieDetail: MovieDetail!
  var rows: [SeatRow] = []
  var selectedSeats: [Seat] = []
  var showtime: Showtime!
  
  //MARK: Init
  
  init(movieDetail: MovieDetail, showtime: Showtime, seatQuantitySelected: Int, client: MoviesProvider = MoviesClient()) {
    self.movieDetail = movieDetail
    self.showtime = showtime
    self.client = client
    self.columns = Array(repeating: GridItem(.fixed(40), spacing: 5), count: numberOfColumns)
    dataPurchase = DataPurchase(movieDetail: movieDetail, showtime: showtime, seatQuantitySelected: seatQuantitySelected)
  }
  
  //MARK: Methods
  
  func fetchSeats() async {
    let rows = await client.fetchSeats()
    let sorted = order(rows: rows)
    
    self.rows = sorted
  }
  
  func didSelect(rowName: String, seat: Seat, isSelected: Bool) {
    guard let rowIndex = rows.firstIndex(where: { $0.rowName == rowName }),
          let seatIndex = rows[rowIndex].seats.firstIndex(where: { $0 == seat }) else {
      return
    }
    
    if seat.isSelected,
      let selectedIndex = selectedSeats.firstIndex(where: { $0 == seat }) {
        selectedSeats.remove(at: selectedIndex)
        rows[rowIndex].seats[seatIndex].isSelected = false
    } else {
      if selectedSeats.count == dataPurchase.seatQuantitySelected { return }
      rows[rowIndex].seats[seatIndex].isSelected = isSelected
      selectedSeats.append(rows[rowIndex].seats[seatIndex])
    }
    
    debugPrint(selectedSeats.count)
  }
  
  //MARK: Private Methods
  
  private func order(rows: [SeatRow]) -> [SeatRow] {
    let sorted = rows.map { row in
      let orderedSeats = row.seats.sorted { $0.position.columnIndex < $1.position.columnIndex }
      return SeatRow(rowName: row.rowName, seats: orderedSeats)
    }.sorted { $0.seats.first?.position.rowIndex ?? 0 < $1.seats.first?.position.rowIndex ?? 0 }
    
    return sorted
  }
}
