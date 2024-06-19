//
//  AppIconNetworkManager.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import Foundation

/// A singleton providing the ability to perform a network request which
/// looks up an app based on its app ID to get the URL of its app icon.
/// The app icon URL is then cached for quickly accessing with future
/// requests to save making another network call.
@MainActor
final class AppIconNetworkManager {
    /// Creates the singleton object.
    static let shared = AppIconNetworkManager()

    /// Creates the cache object for storing the app icon URL.
    private let cache = NSCache<NSString, NSString>()

    private init() {}

    /// Fetches the app icon URL string for a given app.
    /// - Parameter app: The app to retrieve the app icon for.
    /// - Returns: The string containing the URL of the app's icon.
    func fetchURL(for app: any AKApp) async -> String? {
        let urlString = "https://itunes.apple.com/lookup?id=\(app.id)"
        let cacheKey = NSString(string: urlString)

        guard let url = URL(string: urlString) else {
            return nil
        }

        if let cachedImageURL = cache.object(forKey: cacheKey) as? String {
            return cachedImageURL

        } else {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                guard let decodedResponse = try? JSONDecoder().decode(AppResponse.self, from: data),
                   let appIconURL = decodedResponse.results.first?.appIcon else {
                    return nil
                }

                cache.setObject(NSString(string: appIconURL), forKey: cacheKey)
                return appIconURL

            } catch {
                return nil
            }
        }
    }

    /// A custom struct containing the results from the request.
    struct AppResponse: Codable {
        let results: [AppResult]
    }

    /// A custom struct containing the appIcon URL string in the result.
    struct AppResult: Codable {
        let appIcon: String
        
        enum CodingKeys: String, CodingKey {
            case appIcon = "artworkUrl512"
        }
    }
}
