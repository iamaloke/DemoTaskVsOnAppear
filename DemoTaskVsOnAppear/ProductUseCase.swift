//
//  ProductUseCase.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Combine
import SwiftUI

protocol ProductUseCase {
    func getProducts() -> AnyPublisher<[Product], Error>
}

class ProductInteractor: ProductUseCase {
    
    private var repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func getProducts() -> AnyPublisher<[Product], Error> {
        repository.fetchProducts()
    }
}
