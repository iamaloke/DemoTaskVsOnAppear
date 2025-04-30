//
//  Endpoints.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Foundation

enum Endpoints {
    
    static let baseUrl = "https://fakestoreapi.com/"
    
    enum Fetch: String {
        case products = "products"
        
        func getUrl() -> String {
            switch self {
                case .products: return "\(baseUrl)\(self.rawValue)"
            }
        }
    }
}
