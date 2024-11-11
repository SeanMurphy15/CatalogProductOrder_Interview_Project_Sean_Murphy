import Foundation


struct CatalogProduct: Identifiable {

    let id = UUID()
    let name: String
    let productDescription: String
    let size: String?
    let price: Double
    let displayPrice: String

    init(
        name: String,
        productDescription: String,
        size: String?,
        price: Double
    ) {
        self.name = name
        self.productDescription = productDescription
        self.size = size
        self.price = price
        self.displayPrice = currencyFormatter.string(from: price)
    }

}


extension CatalogProduct {

  // simulates a db fetch or a network fetch
  // ❌ do not modify this function ❌
  static func fetchAllProducts(_ completionHandler: @escaping ([CatalogProduct]) -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
      completionHandler([
        .init(
            name: "Battery",
            productDescription: "Size D",
            size: "box of 12",
            price: 2.99),
        .init(
            name: "Battery",
            productDescription: "Size AA",
            size: "box of 24",
            price: 4.99),
        .init(
            name: "Light bulb",
            productDescription: "60w",
            size: nil,
            price: 0.99),
        .init(
            name: "Light bulb",
            productDescription: "120w",
            size: nil,
            price: 0.99),
        .init(
            name: "Light bulb",
            productDescription: "100w",
            size: nil,
            price: 0.99),
        .init(
            name: "Light bulb",
            productDescription: "40w",
            size: nil,
            price: 0.99),
        .init(
            name: "Light saber",
            productDescription: "Jedi weapon",
            size: "1 unit",
            price: 1999.99),
        .init(
            name: "Light saber",
            productDescription: "Sith weapon",
            size: "1 unit",
            price: 1999.99),
        .init(
            name: "Cleaner",
            productDescription: "Cleans everything",
            size: "1 kit",
            price: 9.99),
        .init(
            name: "Drain Cleaner",
            productDescription: "Cleans drains",
            size: "case",
            price: 15.99),
        .init(
            name: "Hot dog",
            productDescription: "All Beef",
            size: "pack of 8",
            price: 3.99),
        .init(
            name: "Hot dog buns",
            productDescription: "for your dog",
            size: "pack of 12",
            price: 2.99),
        .init(
            name: "Ice cream",
            productDescription: "vanilla",
            size: "quart",
            price: 4.99),
        .init(
            name: "Ice cream",
            productDescription: "chocolate",
            size: "quart",
            price: 4.99),
        .init(
            name: "Socks",
            productDescription: "white",
            size: "pack of 12",
            price: 10.99),
        .init(
            name: "Socks",
            productDescription: "black",
            size: "pack of 12",
            price: 10.99),
        .init(
            name: "Blaster",
            productDescription: "shoot the bad guys",
            size: "1 unit",
            price: 1000.99),
        .init(
            name: "X-Wing",
            productDescription: "Rebel figher",
            size: "1 unit",
            price: 10_000_000.00),
        .init(
            name: "Y-Wing",
            productDescription: "Rebel bomber",
            size: "1 unit",
            price: 13_000_000.00),
        .init(
            name: "A-Wing",
            productDescription: "Rebel fighter",
            size: "1 unit",
            price: 9_000_000.00),
        .init(
            name: "B-Wing",
            productDescription: "Rebel fighter",
            size: "1 unit",
            price: 19_000_000.00),
        .init(
            name: "Tie Figher",
            productDescription: "Empire fighter",
            size: "1 unit",
            price: 600_000.00),
        .init(
            name: "Star Destroyer",
            productDescription: "Empire star ship",
            size: "1 unit",
            price: 800_000_000_000.00),
        .init(
            name: "Death Star",
            productDescription: "Planet Destroyer",
            size: "1 unit",
            price: 999_789_860_077_404_690.03),
        .init(
            name: "C-3PO",
            productDescription: "Protocol Droid",
            size: "1 droid",
            price: 34_612.50)
    ])
    }
  }
}
