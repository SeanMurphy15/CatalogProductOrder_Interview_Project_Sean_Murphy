//
//  CatalogProductListViewModel.swift
//  CatalogProductOrder_Interview_Project
//
//  Created by Sean Murphy on 11/10/24.
//

import Foundation
import SwiftUI

class CatalogProductListViewModel: ObservableObject {
  @Published var products: [CatalogProduct] = []
  @Published var isLoading = false
  @Published var productCount: Int = 0
  @Published var searchText = ""
  @Published var quantity: Int? = nil
  @Published var selectedProduct: CatalogProduct? = nil
  @Published var isAddButtonDisabled: Bool = true

  func setOnAppear() {
    isLoading.toggle()
    CatalogProduct.fetchAllProducts { [weak self] products in
      guard let self = self else { return }
      self.products = products
      self.productCount = products.count
      self.isLoading.toggle()
    }
  }

  var productSearchResults: [CatalogProduct] {
    if searchText.isEmpty {
      return products
    } else {
      
      // MARK: - Bonus Implementation

      let trimAndNormalize = trim >>> normalize
      let normalizedSearchText = trimAndNormalize(searchText)

      return products.filter { product in
        let normalizedProductName = normalize(product.name)
        return normalizedProductName.contains(normalizedSearchText)
      }
    }
  }

  func submitProductQuantity() {
    if let validQuantity = quantity {
      productCount = validQuantity + productCount
      resetQuantity()
    }
  }

  func resetQuantity() {
    quantity = nil
  }
  
  func setAddButtonState() {
    isAddButtonDisabled = (quantity == nil)
  }
}

// MARK: - Bonus Implementation Methods

extension CatalogProductListViewModel {
  func trim(_ input: String) -> String {
    input.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  func normalize(_ input: String) -> String {
    input.lowercased().replacingOccurrences(of: " ", with: "")
  }
}
