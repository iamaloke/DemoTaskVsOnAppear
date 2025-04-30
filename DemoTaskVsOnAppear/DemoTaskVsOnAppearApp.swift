//
//  DemoTaskVsOnAppearApp.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import SwiftUI

@main
struct DemoTaskVsOnAppearApp: App {
    var body: some Scene {
        WindowGroup {
            let networkManager = NetworkManager()
            let datasource = FactoryDataSource.makeDataSource(source: .remote, networkService: networkManager)
            let useCase = ProductInteractor(repository: datasource)
            let viewModel = ProductViewModel(useCase: useCase)
            ContentView(viewModel: viewModel)
        }
    }
}
