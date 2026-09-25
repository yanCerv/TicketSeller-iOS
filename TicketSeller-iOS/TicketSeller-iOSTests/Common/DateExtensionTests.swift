//
//  DateExtensionTests.swift
//  TicketSeller-iOSTests
//

import XCTest
@testable import TicketSeller_iOS

final class DateExtensionTests: XCTestCase {

  @MainActor
  func testReturnsFalseWhenExpirationIsMoreThanLeewayAway() throws {
    let fileName = uniqueFileName
    defer { try? FileDataManager.delete(fileName: fileName) }

    try FileDataManager.save(expirationString(after: 120), as: fileName)

    XCTAssertFalse(Date.isAccessOrSessionExpired(using: fileName))
  }

  @MainActor
  func testReturnsTrueWhenExpirationIsWithinLeeway() throws {
    let fileName = uniqueFileName
    defer { try? FileDataManager.delete(fileName: fileName) }

    try FileDataManager.save(expirationString(after: 10), as: fileName)

    XCTAssertTrue(Date.isAccessOrSessionExpired(using: fileName))
  }

  @MainActor
  func testReturnsTrueWhenExpirationIsInThePast() throws {
    let fileName = uniqueFileName
    defer { try? FileDataManager.delete(fileName: fileName) }

    try FileDataManager.save(expirationString(after: -1), as: fileName)

    XCTAssertTrue(Date.isAccessOrSessionExpired(using: fileName))
  }

  @MainActor
  func testReturnsTrueWhenExpirationFileDoesNotExist() {
    XCTAssertTrue(Date.isAccessOrSessionExpired(using: uniqueFileName))
  }

  @MainActor
  func testReturnsTrueWhenExpirationIsInvalid() throws {
    let fileName = uniqueFileName
    defer { try? FileDataManager.delete(fileName: fileName) }

    try FileDataManager.save("invalid-date", as: fileName)

    XCTAssertTrue(Date.isAccessOrSessionExpired(using: fileName))
  }

  private var uniqueFileName: String {
    "token-expiration-\(UUID().uuidString).json"
  }

  private func expirationString(after interval: TimeInterval) -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter.string(from: .now.addingTimeInterval(interval))
  }
}
