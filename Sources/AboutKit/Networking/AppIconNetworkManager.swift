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
final class AppIconNetworkManager {
    /// Creates the singleton object.
    static let shared = AppIconNetworkManager()

    /// Creates the cache object for storing the app icon URL.
    private let cache = NSCache<NSString, NSString>()

    /// Gets the app icon URL string for a given app ID>
    /// - Parameters:
    ///   - appID: The app ID string of the app to retrieve the app icon for.
    ///   - completion: A completion block containing an optional string if a url value is found during the request.
    func getURL(for appID: String, completion: @escaping (String?) -> Void) {
        let urlString = "https://itunes.apple.com/lookup?id=\(appID)"
        let cacheKey = NSString(string: urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImageURL = cache.object(forKey: cacheKey) {
            completion(cachedImageURL as String)
            return
            
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(AppResponse.self, from: data),
                   let appIconURL = decodedResponse.results.first?.appIcon {
                    self.cache.setObject(NSString(string: appIconURL), forKey: cacheKey)
                    completion(appIconURL)
                    
                } else {
                    completion(nil)
                }
                
            }.resume()
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
