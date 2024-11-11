//
//  CatalogProductDetailView.swift
//  CatalogProductOrder_Interview_Project
//
//  Created by Sean Murphy on 11/10/24.
//

import Combine
import SwiftUI

struct CatalogProductDetailView: View {
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject var viewModel: CatalogProductListViewModel

  var body: some View {
    NavigationStack {
      Form {
        productDescriptionSectionView
        quantityInputSectionView
      }
      .toolbar {
        cancelToolbarItemView
        titleToolbarItemView
        addToolbarItemView
      }
      .customToolbar()
    }
  }

  // MARK: - Subviews

  private var productDescriptionSectionView: some View {
    Section(header: Text("DESCRIPTION").padding(.leading, -16)) {
      VStack(alignment: .leading) {
        Text(viewModel.selectedProduct?.productDescription ?? "Product description not available")
        HStack {        
          Text("\(viewModel.selectedProduct?.size ?? "1 each"):")
          Text("\(viewModel.selectedProduct?.displayPrice ?? "N/A")")
        }
        .fontWeight(.light)
      }
      .padding(.bottom, 16)
      .frame(minHeight: 50)
    }
  }

  private var quantityInputSectionView: some View {
    Section {
      HStack {
        Text("Quantity")
        Spacer()
        TextField("", value: $viewModel.quantity, format: .number)
          .keyboardType(.numberPad)
          .textFieldStyle(.roundedBorder)
          .lineLimit(1)
          .multilineTextAlignment(.trailing)
          .frame(width: 75)
          .onChange(of: viewModel.quantity) {
            viewModel.setAddButtonState()
          }
      }
      .frame(height: 40)
    }
  }

  private var cancelToolbarItemView: some ToolbarContent {
    ToolbarItem(placement: .topBarLeading) {
      Button(action: {
        viewModel.resetQuantity()
        dismiss()
      }) {
        Image(systemName: "xmark")
      }
      .fontWeight(.semibold)
      .tint(.darkGreen)
    }
  }

  private var titleToolbarItemView: some ToolbarContent {
    ToolbarItem(placement: .principal) {
      Text(viewModel.selectedProduct?.name.uppercased() ?? "Unknown")
        .fontWeight(.bold)
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .minimumScaleFactor(0.5)
    }
  }

  private var addToolbarItemView: some ToolbarContent {
    ToolbarItem(placement: .topBarTrailing) {
      Button(action: {
        viewModel.submitProductQuantity()
        dismiss()
      }) {
        Text("Add")
          .foregroundStyle(viewModel.isAddButtonDisabled ? .gray : .black)
          .fontWeight(.bold)
      }
      .disabled(viewModel.isAddButtonDisabled)
    }
  }
}

// MARK: - Preview

#Preview {
  previewWrapper()
}

private struct previewWrapper: View {
  var viewModel = CatalogProductListViewModel()

  init() {
    viewModel.selectedProduct = CatalogProduct.mock
  }

  var body: some View {
    CatalogProductDetailView()
      .environmentObject(viewModel)
  }
}
