//
//  RemoteImageView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct RemoteImageView: View {
    private enum LoadState {
        case loading
        case error
        case loaded(image: PlatformImage)
    }
    
    @StateObject private var imageLoader: RemoteImageLoader
    
    private var downloadedImage: Image {
        switch imageLoader.loadState {
        case .loading, .error:
            #if os(macOS)
            return Image(nsImage: NSImage())
            #else
            return Image(uiImage: UIImage())
            #endif
        case .loaded(let image):
            #if os(macOS)
            return Image(nsImage: image)
            #else
            return Image(uiImage: image)
            #endif
        }
    }
    
    init(url: String) {
        _imageLoader = StateObject(wrappedValue: RemoteImageLoader(url: url))
    }
    
    var body: some View {
        downloadedImage.resizable()
    }
    
    private class RemoteImageLoader: ObservableObject {
        @Published var loadState = LoadState.loading
        
        private let cache = NSCache<NSString, PlatformImage>()
        
        init(url: String) {
            Task {
                await loadAppIcon(from: url)
            }
        }

        @MainActor private func loadAppIcon(from urlString: String) async {
            loadState = .loading

            let cacheKey = NSString(string: urlString)

            guard let url = URL(string: urlString) else {
                loadState = .error
                return
            }

            if let cachedImage = cache.object(forKey: cacheKey) {
                loadState = .loaded(image: cachedImage)
            } else {
                do {
                    let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))

                    guard let image = PlatformImage(data: data) else {
                        loadState = .error
                        return
                    }

                    cache.setObject(image, forKey: cacheKey)
                    loadState = .loaded(image: image)

                } catch {
                    loadState = .error
                }
            }
        }
    }
}
