import SwiftUI

struct CatalogProductListView: View {
  @StateObject private var viewModel = CatalogProductListViewModel()
  
  var body: some View {
    VStack {
      if viewModel.isLoading {
        loadingView
      } else {
        productListView
      }
    }
    .toolbar {
      toolbarTitleItemView
      toolbarItemLabelView
    }
    .customToolbar()
    .onAppear {
      viewModel.setOnAppear()
    }
    .environmentObject(viewModel)
  }
  
  // MARK: - Subviews
  
  private var loadingView: some View {
    ProgressView()
      .controlSize(.large)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  private var productListView: some View {
    
    Group {
      if viewModel.productSearchResults.isEmpty {
        EmptyResultsView
      } else {
        List {
          ForEach(viewModel.productSearchResults) { catalogProduct in
            CatalogProductRowView(catalogProduct: catalogProduct)
          }
        }
        .listStyle(.plain)
      }
    }
    .searchable(text: $viewModel.searchText, placement: .toolbar)
    .autocorrectionDisabled(true)
    .searchPresentationToolbarBehavior(.avoidHidingContent)
    .fullScreenCover(item: $viewModel.selectedProduct) { _ in
      CatalogProductDetailView()
    }
  }
  
  private var EmptyResultsView: some View {
      VStack(spacing: 16) {
        Image(systemName: "sparkle.magnifyingglass")
          .resizable()
          .scaledToFit()
          .frame(width: 50, height: 50)
          .foregroundColor(.gray)
          .symbolEffect(.scale.up.wholeSymbol, options: .repeating)
        Text("No Products Found")
          .font(.headline)
          .foregroundColor(.secondary)
        Text("Try adjusting your search criteria.")
          .font(.subheadline)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 40)
          .foregroundColor(.secondary)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  private var toolbarTitleItemView: some ToolbarContent {
    ToolbarItem(placement: .principal) {
      Text("PRODUCTS")
        .bold()
    }
  }
  
  private var toolbarItemLabelView: some ToolbarContent {
    ToolbarItem(placement: .primaryAction) {
      Text("Items: \(viewModel.productCount)")
    }
  }
}

// MARK: - Preview

#Preview {
  NavigationStack {
    CatalogProductListView()
  }
}
