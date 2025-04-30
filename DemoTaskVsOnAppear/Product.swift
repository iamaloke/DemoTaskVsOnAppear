//
//  Product.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: URL
    let rating: Rating
}

struct Rating: Decodable {
    let rate: Double
    let count: Int
}
