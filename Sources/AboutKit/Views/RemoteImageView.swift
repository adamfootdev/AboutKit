//
//  RemoteImageView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct RemoteImageView: View {
    private enum LoadState {
        case loading, success, failure
    }
    
    @StateObject private var imageLoader: RemoteImageLoader
    
    private var downloadedImage: Image {
        switch imageLoader.loadState {
        case .loading, .failure:
            return Image(uiImage: UIImage())
        case .success:
            if let image = imageLoader.image {
                return Image(uiImage: image)
            } else {
                return Image(uiImage: UIImage())
            }
        }
    }
    
    init(url: String) {
        _imageLoader = StateObject(wrappedValue: RemoteImageLoader(url: url))
    }
    
    var body: some View {
        downloadedImage.resizable()
    }
    
    private class RemoteImageLoader: ObservableObject {
        var image: UIImage?
        var loadState = LoadState.loading
        
        private let cache = NSCache<NSString, UIImage>()
        
        init(url: String) {
            guard let imageURL = URL(string: url) else { return }
            
            let cacheKey = NSString(string: url)
            
            if let cachedImage = cache.object(forKey: cacheKey) {
                self.image = cachedImage
                self.loadState = .success
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
                
            } else {
                URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    guard error == nil,
                          let data = data,
                          let image = UIImage(data: data) else {
                        self.loadState = .failure
                        return
                    }
                    
                    self.image = image
                    self.loadState = .success
                    
                    self.cache.setObject(image, forKey: cacheKey)
                    
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                    
                }.resume()
            }
        }
    }
}
