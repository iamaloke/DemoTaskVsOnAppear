//
//  AsyncPhoto.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 01/05/25.
//

import Combine
import Foundation

class AsyncPhoto {
    
    private var cache = NSCache<NSString, NSData>()
    private let cacheQueue = DispatchQueue(label: "com.imalok.cacheQueue")
    
    static let shared = AsyncPhoto()
    
    private init() {}
    
    func download(imageUrl: URL?) -> AnyPublisher<Data, Error> {
        guard let url = imageUrl else {
            return Fail(error: NSError(domain: "URL not found", code: 404)).eraseToAnyPublisher()
        }
        
        if let cachedData = cacheQueue.sync(execute: {
            cache.object(forKey: url.absoluteString as NSString)
        }) {
            debugPrint("loaded from cache")
            return Just(cachedData as Data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { [weak self] result in
                guard let response = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                guard (200...299).contains(response.statusCode) else {
                    throw URLError(.init(rawValue: response.statusCode))
                }
                
                guard let self = self else {
                    throw NSError(domain: "self deallocated", code: 501)
                }
                
                self.cacheQueue.async {
                    debugPrint("cached: \(url.absoluteString)")
                    self.cache.setObject(result.data as NSData, forKey: url.absoluteString as NSString)
                }
                
                return result.data
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
