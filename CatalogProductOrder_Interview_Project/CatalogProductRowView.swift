//
//  CatalogProductRowView.swift
//  CatalogProductOrder_Interview_Project
//
//  Created by Sean Murphy on 11/10/24.
//

import SwiftUI

struct CatalogProductRowView: View {
  var product: CatalogProduct
  @Binding var selectedProduct: CatalogProduct?
  
  var body: some View {
    Button(action: {
      selectedProduct = product
    }) {
      HStack {
        productInfoView
        Spacer()
        productDetailsView
      }
      .contentShape(Rectangle())
      .padding(.vertical, 8)
    }
    .buttonStyle(PlainButtonStyle())
  }
  
  // MARK: - Subviews
  
  private var productInfoView: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(product.name)
        .font(.headline)
      Text(product.productDescription)
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }
  
  private var productDetailsView: some View {
    VStack(alignment: .trailing, spacing: 4) {
      if let size = product.size {
        Text(size)
          .font(.caption)
          .foregroundColor(.secondary)
      }
      Text(product.displayPrice)
        .font(.caption)
        .bold()
    }
  }
}

#Preview {
  Preview()
}

private struct Preview: View {
  
  @State private var selectedProduct: CatalogProduct? = nil
  
  var body: some View {
    CatalogProductRowView(
      product: CatalogProduct(
        name: "Battery",
        productDescription: "Size D",
        size: "box of 12",
        price: 2.99
      ),
      selectedProduct: $selectedProduct
    )
  }
}
