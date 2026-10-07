//
//  Showtime.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

struct MovieShowtime: Codable, Hashable {
  let movieId: Int
   let date: String
   let timeZone: String
   let showtimes: [Showtime]
  
  init(movieId: Int = 0, date: String = "", timeZone: String = "", showtimes: [Showtime] = []) {
    self.movieId = movieId
    self.date = date
    self.timeZone = timeZone
    self.showtimes = showtimes
  }
  
  static func emptyObject() -> MovieShowtime {
    return MovieShowtime()
  }
}

struct Showtime: Codable, Hashable {
  let id: String
  let movieId: Int
  let startsAt: String
  let time: String
  let cinema: String
  let auditorium: String
  let screenType: String
  let price: Double
  let currency: String
  
  init(id: String, movieId: Int, startsAt: String, time: String, cinema: String, auditorium: String, screenType: String, price: Double, currency: String) {
    self.id = id
    self.movieId = movieId
    self.startsAt = startsAt
    self.time = time
    self.cinema = cinema
    self.auditorium = auditorium
    self.screenType = screenType
    self.price = price
    self.currency = currency
  }
}
