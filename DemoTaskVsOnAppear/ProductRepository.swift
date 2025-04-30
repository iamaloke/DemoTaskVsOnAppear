//
//  ProductRepository.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Combine
import Foundation

protocol ProductRepository {
    func fetchProducts() -> AnyPublisher<[Product], Error>
}

protocol ProductDataSource {
    func getProducts()
}

enum SourceType {
    case remote, local
}

final class FactoryDataSource {
    
    static func makeDataSource(source type: SourceType) -> ProductRepository {
        switch type {
            case .remote: ProductRemoteDataSource()
            case .local: ProductLocalDataSource()
        }
    }
    
}

final class ProductRemoteDataSource: ProductRepository {
    
    private var networkService: NetworkService? = nil
    
    func fetchProducts() -> AnyPublisher<[Product], Error> {
        Future { [weak self] promise in
            Task {
                do {
                    guard let self = self, let networkService = self.networkService else { return }
                    let data: [Product] = try await networkService.request(endpoint: Endpoints.Fetch.products.getUrl(), method: .get)
                    promise(.success(data))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

final class ProductLocalDataSource: ProductRepository {
    func fetchProducts() -> AnyPublisher<[Product], Error> {
        Fail(error: NSError(domain: "Not yet implement", code: 500))
            .eraseToAnyPublisher()
    }
}
