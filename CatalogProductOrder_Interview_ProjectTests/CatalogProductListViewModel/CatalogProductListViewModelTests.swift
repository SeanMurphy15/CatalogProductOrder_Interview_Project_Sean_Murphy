//
//  CatalogProductListViewModelTests.swift
//  CatalogProductOrder_Interview_ProjectTests
//
//  Created by Sean Murphy on 11/10/24.
//

import Combine
import XCTest

class CatalogProductListViewModelTests: XCTestCase {
  var cancellables: Set<AnyCancellable> = []
  var viewModel: CatalogProductListViewModel!

  override func setUp() {
    super.setUp()
    viewModel = CatalogProductListViewModel()
  }

  override func tearDown() {
    cancellables.removeAll()
    viewModel = nil
    super.tearDown()
  }

  func testSetOnAppear_SuccessfulResponse_ProductsPopulated() {
      // Arrange
      let expectation = self.expectation(description: "Products should be populated after setOnAppear is called")
      
      // Act
      let cancellable = viewModel.$isLoading.sink { isLoading in
          if !isLoading && !self.viewModel.products.isEmpty {
              expectation.fulfill()
          }
      }
      viewModel.setOnAppear()
      
      // Assert
      waitForExpectations(timeout: 8.5, handler: nil)
      self.cancellables.insert(cancellable)
      XCTAssertFalse(viewModel.isLoading, "isLoading should be false")
      XCTAssertFalse(viewModel.products.isEmpty, "Products should be populated after setOnAppear is called")
      XCTAssertEqual(viewModel.productCount, viewModel.products.count, "Product count should match the number of products fetched")
  }

  func testSelectProduct_ProductSelectedSuccessfully() {
    // Arrange
    let mockCatalogProduct1 = CatalogProduct.mock
    mockCatalogProduct1.name = "X-Wing Starfighter"
    let mockCatalogProduct2 = CatalogProduct.mock
    mockCatalogProduct2.name = "Millennium Falcon"
    let mockCatalogProduct3 = CatalogProduct.mock
    mockCatalogProduct3.name = "Death Star Model"
    viewModel.products = [mockCatalogProduct1, mockCatalogProduct2, mockCatalogProduct3]
    viewModel.searchText = "death star"

    // Act
    let results = viewModel.productSearchResults
    // Assert
    XCTAssertEqual(results.count, 1, "Search results should return one product matching the search text")
    XCTAssertEqual(results.first?.name, "Death Star Model", "The product name should match the expected search result name")
  }

  func testSubmitProductQuantity_ValidQuantity_ProductCountUpdated() {
    // Arrange
    viewModel.productCount = 5
    viewModel.quantity = 3

    // Act
    viewModel.submitProductQuantity()

    // Assert
    XCTAssertEqual(viewModel.productCount, 8, "Product count should be updated with the submitted quantity")
    XCTAssertNil(viewModel.quantity, "Quantity should be reset to nil after submission")
  }

  func testSetAddButtonState_QuantityIsNil_AddButtonDisabled() {
    // Arrange
    viewModel.quantity = nil

    // Act
    viewModel.setAddButtonState()

    // Assert
    XCTAssertTrue(viewModel.isAddButtonDisabled, "Add button should be disabled when quantity is nil")
  }

  func testSetAddButtonState_QuantityIsNotNil_AddButtonEnabled() {
    // Arrange
    viewModel.quantity = 5

    // Act
    viewModel.setAddButtonState()

    // Assert
    XCTAssertFalse(viewModel.isAddButtonDisabled, "Add button should be enabled when quantity is not nil")
  }

  func testProductSearchResults_TrimAndNormalizeSearchText() {
    // Arrange
    let mockCatalogProduct1 = CatalogProduct.mock
    mockCatalogProduct1.name = "X-Wing Starfighter"
    let mockCatalogProduct2 = CatalogProduct.mock
    mockCatalogProduct2.name = "Millennium Falcon"
    let mockCatalogProduct3 = CatalogProduct.mock
    mockCatalogProduct3.name = "Death Star Model"
    viewModel.products = [mockCatalogProduct1, mockCatalogProduct2, mockCatalogProduct3]
    viewModel.searchText = "   Death  Sta  "

    // Act
    let results = viewModel.productSearchResults
    // Assert
    XCTAssertEqual(results.count, 1, "Search results should return one product after trimming and normalizing the search text")
    XCTAssertEqual(results.first?.name, "Death Star Model", "The product name should match the expected search result name after trimming and normalization")
  }
}
