//
//  ContentView.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ProductViewModel
    
    init() {
        let networkManager = NetworkManager()
        let datasource = FactoryDataSource.makeDataSource(source: .remote, networkService: networkManager)
        let useCase = ProductInteractor(repository: datasource)
        _viewModel = StateObject(wrappedValue: ProductViewModel(useCase: useCase))
    }
    
    var body: some View {
        ProductListView(viewModel: viewModel)
            .task {
                viewModel.fetchProducts()
            }
    }
}

struct ProductListView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.products, id: \.id) { product in
                    VStack {
                        HStack(alignment: .top) {
                            ImageView(imageUrl: product.image)
                            .frame(width: 120)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(product.title)
                                    .fontWeight(.medium)
                                
                                Text(String(format: "%.2f", product.price))
                                    .fontWeight(.bold)
                                
                                Text(product.category)
                                    .underline()
                                
                                Text(product.description)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
    }
}
