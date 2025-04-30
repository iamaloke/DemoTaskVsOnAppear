//
//  NetworkService.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 30/04/25.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkService {
    func request<T: Decodable>(endpoint: String, method: HttpMethod) async throws -> T
}

final class NetworkManager: NetworkService {
    func request<T: Decodable>(endpoint: String, method: HttpMethod) async throws -> T {
        guard let url = URL(string: "https://dummyjson.com/\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.httpMethod = method.rawValue
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
