//
//  ProductViewModel.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Combine
import SwiftUI

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase: ProductUseCase
    
    init(useCase: ProductUseCase) {
        self.useCase = useCase
    }
    
    func fetchProducts() {
        useCase
            .getProducts()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                    case .finished: print("Products fetched successfully")
                    case .failure(let error): print("Error: \(error)")
                }
            } receiveValue: { [weak self] products in
                guard let self = self else { return }
                self.products = products
            }
            .store(in: &cancellables)
    }
}
