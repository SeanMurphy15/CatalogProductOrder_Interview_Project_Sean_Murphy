import SwiftUI

@main
struct CataloProductsApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            ContentView(products: [])
          }
        }
    }
}
