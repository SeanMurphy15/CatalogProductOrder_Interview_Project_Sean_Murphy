import SwiftUI

class ViewModel: ObservableObject {
  
}

struct ContentView: View {
  @State var products: [CatalogProduct]
  @State private var searchText = ""
  @State private var isLoading = false
  @State var selectedProduct: CatalogProduct? = nil
  
  var productSearchResults: [CatalogProduct] {
    if searchText.isEmpty {
      return products
    } else {
      let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
      let normalizedSearchText = trimmedSearchText.replacingOccurrences(of: " ", with: "")
      
      return products.filter { product in
        let normalizedProductName = product.name.lowercased().replacingOccurrences(of: " ", with: "")
        return normalizedProductName.contains(normalizedSearchText)
      }
    }
  }
  
  var body: some View {
      VStack {
        if isLoading {
          ProgressView()
            .controlSize(.regular)
            .scaleEffect(1.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        List {
          ForEach(productSearchResults) { product in
            CatalogProductRowView(product: product) { selectedProduct in
              self.selectedProduct = selectedProduct
            }
          }
        }
        .listStyle(.plain)
        .onAppear {
          isLoading.toggle()
          CatalogProduct.fetchAllProducts { products in
            self.products = products
            isLoading.toggle()
          }
        }
        .toolbar {
          ToolbarItem(placement: .principal) {
            Text("PRODUCTS")
              .bold()
          }
          ToolbarItem(placement: .primaryAction) {
            Text("Items: \(products.count)")
          }
        }
        .toolbarBackground(
            Color.white,
            for: .navigationBar)
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
      }
      .searchable(text: $searchText, placement: .toolbar)
      .searchPresentationToolbarBehavior(.avoidHidingContent)
      .fullScreenCover(item: $selectedProduct) { selectedProduct in
        CatalogProductDetailView(product: selectedProduct) { quantity in
          print(quantity)
        }
      }
    }
}

#Preview {
  NavigationStack {
    ContentView(products: [])
  }
}

internal let currencyFormatter = CurrencyFormatter()

internal class CurrencyFormatter: NumberFormatter {
  
  override init() {
    super.init()
    self.numberStyle = .currency
    self.negativeFormat = "-¤#,##0.00"
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  internal func string(from double: Double) -> String {
    string(from: NSNumber(value: double))!
  }
}
