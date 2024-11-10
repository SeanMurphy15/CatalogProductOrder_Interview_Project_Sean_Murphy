import SwiftUI

struct ContentView: View {
  @State var products: [CatalogProduct]

  var body: some View {
    List {
      ForEach(products, id: \.id) { product in
        HStack {
          VStack(alignment: .leading) {
            Text(product.name)
            Text(product.productDescription)
              .font(.caption)
          }
          Spacer()
          VStack(alignment: .trailing) {
            if let size = product.size {
              Text(size)
            }
            Text(currencyFormatter.string(from: product.price))
          }
          .font(.caption)
        }
      }
    }
    .listStyle(.plain)
    .onAppear {
      CatalogProduct.fetchAllProducts { products in
        self.products = products
      }
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Text("Items: (0)")
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
