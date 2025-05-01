//
//  ImageView.swift
//  DemoTaskVsOnAppear
//
//  Created by Alok Kumar on 01/05/25.
//

import Combine
import SwiftUI

struct ImageView: View {
    
    @State private var image: Image?
    @State private var cancellables = Set<AnyCancellable>()
    
    var imageUrl: URL?
    
    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear {
                        AsyncPhoto.shared.download(imageUrl: imageUrl)
                            .sink { completion in
                                if case .failure(let error) = completion {
                                    print("Image error: \(error)")
                                    self.image = Image(systemName: "photo")
                                }
                            } receiveValue: { imageData in
                                if let uiImage = UIImage(data: imageData) {
                                    self.image = Image(uiImage: uiImage)
                                } else {
                                    self.image = Image(systemName: "photo")
                                }
                            }
                            .store(in: &cancellables)
                    }
            }
        }
    }
}

#Preview {
    ImageView(imageUrl: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"))
}
