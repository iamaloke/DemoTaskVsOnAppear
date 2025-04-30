//
//  ContentView.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ProductViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    DetailView()
                } label: {
                    Text("Click")
                }
            }
            .padding()
            .task {
                viewModel.getProducts()
            }
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
    }
}
