//
//  ProductUseCase.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Combine
import Foundation

protocol ProductUseCase {
    func getProducts() -> AnyPublisher<[Product], Error>
}

final class ProductInteractor: ProductUseCase {
    
    private var repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func getProducts() -> AnyPublisher<[Product], Error> {
        repository.fetchProducts()
    }
}
