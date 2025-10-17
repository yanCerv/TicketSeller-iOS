//
//  Showtime.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

struct MovieShowtime: Codable, Hashable {
  let movieId: Int
  let showtimes: [Showtime]
  
  init(movieId: Int = 0, showtimes: [Showtime] = []) {
    self.movieId = movieId
    self.showtimes = showtimes
  }
  
  static func emptyObject() -> MovieShowtime {
    return MovieShowtime()
  }
}

struct Showtime: Codable, Hashable {
  let time: String
  let cinema: String
  let screenType: String
  let price: Double
  
  static func generateMock(count: Int = 3) -> [Showtime] {
    let times = ["12:35", "14:45", "17:00", "19:30", "21:45", "23:00"]
    let cinemas = ["Cine", "Cine VIP", "Cine Premium"]
    let formats = ["2D", "3D", "IMAX", "4K", "4K Dolby Atmos"]
    let prices = [35.0, 40.0, 45.0, 50.0]
    
    return (0..<count).map { _ in
      Showtime(
        time: times.randomElement()!,
        cinema: cinemas.randomElement()!,
        screenType: formats.randomElement()!,
        price: prices.randomElement()!
      )
    }
  }
}
