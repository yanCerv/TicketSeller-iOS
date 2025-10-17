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
    self.fileName = "showtime_\(movieId).json"

    if let saved = LocalDataManager.shared.loadData(from: fileName, type: MovieShowtime.self) {
      self.movieShowtimes = saved
    } else {
      self.movieShowtimes = MovieShowtime(movieId: movieId, showtimes: Showtime.generateMock(count: Int.random(in: 2...5)))
      LocalDataManager.shared.saveData(movieShowtimes, to: fileName)
    }
  }
  
  static func getMovieShowtimes(from movieId: Int) -> MovieShowtime {
    let fileName = "showtime_\(movieId).json"
    if let currentShowtimes = LocalDataManager.shared.loadData(from: fileName, type: MovieShowtime.self) {
      return currentShowtimes
    }
    return MovieShowtime(movieId: movieId, showtimes: [])
  }
  
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
