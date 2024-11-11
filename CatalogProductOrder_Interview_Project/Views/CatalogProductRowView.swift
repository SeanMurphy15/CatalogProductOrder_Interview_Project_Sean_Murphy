//
//  CatalogProductRowView.swift
//  CatalogProductOrder_Interview_Project
//
//  Created by Sean Murphy on 11/10/24.
//

import SwiftUI

struct CatalogProductRowView: View {
  var catalogProduct: CatalogProduct
  @EnvironmentObject var viewModel: CatalogProductListViewModel

  var body: some View {
    Button(action: {
      viewModel.selectedProduct = catalogProduct
    }) {
      HStack {
        productInfoView
        Spacer()
        productDetailsView
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(PlainButtonStyle())
  }

  // MARK: - Subviews

  private var productInfoView: some View {
    VStack(alignment: .leading) {
      Text(catalogProduct.name)
      Text(catalogProduct.productDescription)
        .font(.caption)
    }
  }

  private var productDetailsView: some View {
    VStack(alignment: .trailing) {
      if let size = catalogProduct.size {
        Text(size)
          .font(.caption)
      }
      Text(catalogProduct.displayPrice)
        .font(.caption)
    }
  }
}

// MARK: - Preview

#Preview {
  List {
    CatalogProductRowView(
      catalogProduct: CatalogProduct.mock).environmentObject(CatalogProductListViewModel())
  }
  .listStyle(.inset)
  .previewLayout(.sizeThatFits)
}
