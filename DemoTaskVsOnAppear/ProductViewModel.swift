//
//  ProductViewModel.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Combine
import SwiftUI

final class ProductViewModel: ObservableObject {
    
    @Published private var products: [Product] = []
    
}
