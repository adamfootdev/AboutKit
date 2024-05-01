//
//  RemoteImageLoader.swift
//  AboutKit
//
//  Created by Adam Foot on 03/08/2023.
//

import Foundation

@MainActor
final class RemoteImageLoader: ObservableObject {
    @Published var loadState = RemoteImageLoadState.loading

    private let cache = NSCache<NSString, PlatformImage>()

    init(url: String) {
        Task {
            await loadAppIcon(for: url)
        }
    }

    private func loadAppIcon(
        for urlString: String
    ) async {
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
                let (data, _) = try await URLSession.shared.getData(for: URLRequest(url: url))

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
