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
  
  var dataPurchase: DataPurchase
  let columns: [GridItem]
  
  let numberOfColumns: Int = 20

  var movieDetail: MovieDetail!
  var showtime: Showtime!

  var rows: [SeatRow] = []
  var selectedSeats: [Seat] = []
  var isActiveButton: Bool = false
  var isLoaded: Bool = false
  var alertMessage: String = ""
  var showAlert: Bool = false
  
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
    guard !isLoaded else { return }
    do {
      let response = try await client.fetchSeats(showtimeId: showtime.id)
      guard response.showtimeId == showtime.id else { throw ErrorHandler.requestFail }
      rows = order(rows: response.rows)
      isLoaded = true
    } catch {
      alertMessage = (error as? ErrorHandler)?.message ?? "No fue posible cargar los asientos."
      showAlert = true
    }
  }
  
  func didSelect(rowId: String, seatId: String) {
    guard let rowIndex = rows.firstIndex(where: { $0.id == rowId }),
          let seatIndex = rows[rowIndex].seats.firstIndex(where: { $0.id == seatId }) else {
      return
    }

    let seat = rows[rowIndex].seats[seatIndex]
    guard seat.status == .available else { return }
    
    if seat.isSelected,
      let selectedIndex = selectedSeats.firstIndex(where: { $0.id == seat.id }) {
      selectedSeats.remove(at: selectedIndex)
      rows[rowIndex].seats[seatIndex].isSelected = false
      rows[rowIndex].seats[seatIndex].rowSeat = ""
    } else {
      if selectedSeats.count == dataPurchase.seatQuantitySelected { return }
      rows[rowIndex].seats[seatIndex].isSelected = true
      rows[rowIndex].seats[seatIndex].rowSeat = rows[rowIndex].rowName
      selectedSeats.append(rows[rowIndex].seats[seatIndex])
    }
    
    isActiveButton = selectedSeats.count == dataPurchase.seatQuantitySelected
    dataPurchase.selectedSeats = selectedSeats
  }
  
  //MARK: Private Methods
  
  private func order(rows: [SeatRow]) -> [SeatRow] {
    let sorted = rows
      .filter { !$0.seats.isEmpty }
      .map { row in
      let orderedSeats = row.seats.sorted { $0.position.columnIndex < $1.position.columnIndex }
      return SeatRow(id: row.id, rowName: row.rowName, seats: orderedSeats)
    }
      .sorted { left, right in
        guard let leftRowIndex = left.seats.first?.position.rowIndex,
              let rightRowIndex = right.seats.first?.position.rowIndex else {
          return false
        }
        return leftRowIndex < rightRowIndex
      }
    
    return sorted
  }
}
