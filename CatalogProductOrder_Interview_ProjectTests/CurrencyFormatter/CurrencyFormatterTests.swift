//  CurrencyFormatterTests.swift
//  CatalogProductOrder_Interview_ProjectTests
//
//  Created by Sean Murphy on 11/11/24.
//

import XCTest

class CurrencyFormatterTests: XCTestCase {
  override func setUp() {
    super.setUp()
    CurrencyFormatter.shared.locale = Locale(identifier: "en_US")
  }

  func testCurrencyFormatter_PositiveValue_ShouldCorrectlyFormat() {
    // Arrange
    let value: Double = 1234.56
    let formatter = CurrencyFormatter.shared

    // Act
    let formattedString = formatter.string(from: value)

    // Assert
    XCTAssertEqual(formattedString, "$1,234.56", "CurrencyFormatter did not correctly format a positive value.")
  }

  func testCurrencyFormatter_NegativeValue_ShouldCorrectlyFormat() {
    // Arrange
    let value: Double = -1234.56
    let formatter = CurrencyFormatter.shared

    // Act
    let formattedString = formatter.string(from: value)

    // Assert
    XCTAssertEqual(formattedString, "-$1,234.56", "CurrencyFormatter did not correctly format a negative value.")
  }

  func testCurrencyFormatter_ZeroValue_ShouldCorrectlyFormat() {
    // Arrange
    let value: Double = 0.0
    let formatter = CurrencyFormatter.shared

    // Act
    let formattedString = formatter.string(from: value)

    // Assert
    XCTAssertEqual(formattedString, "$0.00", "CurrencyFormatter did not correctly format a zero value.")
  }

  func testCurrencyFormatter_LargeValue_ShouldCorrectlyFormat() {
    // Arrange
    let value: Double = 1234567890.12
    let formatter = CurrencyFormatter.shared

    // Act
    let formattedString = formatter.string(from: value)

    // Assert
    XCTAssertEqual(formattedString, "$1,234,567,890.12", "CurrencyFormatter did not correctly format a large value.")
  }

  func testCurrencyFormatter_LargeUnderscoredValue_ShouldCorrectlyFormat() {
    // Arrange
    let value: Double = 1234567890.12
    let formatter = CurrencyFormatter.shared

    // Act
    let formattedString = formatter.string(from: value)

    // Assert
    XCTAssertEqual(formattedString, "$1,234,567,890.12", "CurrencyFormatter did not correctly format a large value.")
  }

  func testCurrencyFormatter_SingletonInstance_ShouldBeEqual() {
    // Arrange & Act
    let formatter1 = CurrencyFormatter.shared
    let formatter2 = CurrencyFormatter.shared

    // Assert
    XCTAssertTrue(formatter1 === formatter2, "CurrencyFormatter shared instance is not the same.")
  }

  func testCurrencyFormatter_SmallDecimalValue_ShouldCorrectlyRoundAndFormat() {
    // Arrange
    let value: Double = 0.009
    let formatter = CurrencyFormatter.shared

    // Act
    let formattedString = formatter.string(from: value)

    // Assert
    XCTAssertEqual(formattedString, "$0.01", "CurrencyFormatter did not correctly round a small decimal value.")
  }

  func testCurrencyFormatter_ForiegnLocale_ShouldCorrectlyFormat() {
    // Arrange
    let value: Double = 1234.56
    let formatter = CurrencyFormatter.shared
    formatter.locale = Locale(identifier: "de_DE")

    // Act
    let formattedString = formatter.string(from: value)

    // Assert
    XCTAssertEqual(formattedString, "1.234,56 €", "CurrencyFormatter did not correctly format value for Euro locale.")
  }

  func testCurrencyFormatter_InvalidValue_ShouldReturnEmptyString() {
    // Arrange
    let formatter = CurrencyFormatter.shared
    
    // Act
    let formattedString = formatter.string(from: Double.nan)
    // Act & Assert
    XCTAssertEqual(formattedString, "", "CurrencyFormatter should return an empty string.")
  }
}
