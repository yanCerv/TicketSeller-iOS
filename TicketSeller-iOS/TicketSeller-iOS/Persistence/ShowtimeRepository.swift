//
//  ShowtimeRepository.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

@MainActor
final class ShowtimeRepository {
  private(set) var movieShowtimes: MovieShowtime?
  private let fileName: String
  
  init(movieId: Int) {
    self.fileName = FileDataManager.showtimes(id: "\(movieId)")
    if let saved = try? FileDataManager.load(MovieShowtime.self, from: fileName) {
      self.movieShowtimes = saved
    } else {
      self.movieShowtimes = MovieShowtime(movieId: movieId, showtimes: Showtime.generateMock(count: Int.random(in: 2...5)))
      try? FileDataManager.save(movieShowtimes, as: fileName)
    }
  }
  
  static func getMovieShowtimes(from movieId: Int) -> MovieShowtime {
    let fileName = FileDataManager.showtimes(id: "\(movieId)")
    if let currentShowtimes = try? FileDataManager.load(MovieShowtime.self, from: fileName) {
      return currentShowtimes
    }
    return MovieShowtime(movieId: movieId, showtimes: [])
  }
  
  //Move logic to manager
  static func clearAllCache() {
    let fileManager = FileManager.default
    let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    do {
      let contents = try fileManager.contentsOfDirectory(atPath: directory.path)
      for file in contents where file.hasPrefix("showtime_") && file.hasSuffix(".json") {
        let fullPath = directory.appendingPathComponent(file)
        try fileManager.removeItem(at: fullPath)
      }
    } catch {
      print("⚠️ Error clearing showtime cache: \(error)")
    }
  }
}
