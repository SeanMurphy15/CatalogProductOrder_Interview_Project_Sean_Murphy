//
//  CatalogProductDetailView.swift
//  CatalogProductOrder_Interview_Project
//
//  Created by Sean Murphy on 11/10/24.
//

import SwiftUI
import Combine

struct CatalogProductDetailView: View {
    @State var product: CatalogProduct
    @State private var quantity: Int? = nil
    @State private var isAddButtonDisabled: Bool = true
    var didSubmitQuantity: (Int) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                ProductDescriptionSection(product: product)
                QuantityInputSection(quantity: $quantity, isAddButtonDisabled: $isAddButtonDisabled)
            }
            .toolbar {
                CancelToolbarItem(dismiss: dismiss)
                TitleToolbarItem(productName: product.name)
                AddToolbarItem(isAddButtonDisabled: isAddButtonDisabled, quantity: quantity, didSubmitQuantity: didSubmitQuantity, dismiss: dismiss)
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
        }
    }
}

// MARK: - Subviews

struct ProductDescriptionSection: View {
    var product: CatalogProduct

    var body: some View {
        Section(header: Text("DESCRIPTION").padding(.leading, -16)) {
            VStack(alignment: .leading) {
                Text(product.productDescription)
                Text("1 each: \(product.displayPrice)")
            }
            .padding(.bottom, 16)
            .frame(height: 50)
        }
    }
}

struct QuantityInputSection: View {
    @Binding var quantity: Int?
    @Binding var isAddButtonDisabled: Bool

    var body: some View {
        Section {
            HStack {
                Text("Quantity")
                Spacer()
                TextField("", value: $quantity, format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(1)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 75)
                    .onChange(of: quantity) {
                        isAddButtonDisabled = (quantity == nil)
                    }
            }
            .frame(height: 40)
        }
    }
}

struct CancelToolbarItem: ToolbarContent {
    var dismiss: DismissAction

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: dismiss.callAsFunction) {
                Image(systemName: "xmark")
            }
            .tint(.darkGreen)
        }
    }
}

struct TitleToolbarItem: ToolbarContent {
    var productName: String

    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(productName.uppercased())
                .bold()
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
        }
    }
}

struct AddToolbarItem: ToolbarContent {
    var isAddButtonDisabled: Bool
    var quantity: Int?
    var didSubmitQuantity: (Int) -> Void
    var dismiss: DismissAction

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: addProduct) {
                Text("Add")
                    .foregroundStyle(isAddButtonDisabled ? .gray : .black)
                    .bold()
            }
            .disabled(isAddButtonDisabled)
        }
    }

    private func addProduct() {
        if let validQuantity = quantity {
            didSubmitQuantity(validQuantity)
            dismiss()
        }
    }
}

#Preview {
    CatalogProductDetailView(product: CatalogProduct(
        name: "Fly Bait Station Replacement Fee some more really long text",
        productDescription: "Fly Bait Station Replacement Fee",
        size: "N/A",
        price: 9.88
    )) { quantity in
        print(quantity)
    }
}
