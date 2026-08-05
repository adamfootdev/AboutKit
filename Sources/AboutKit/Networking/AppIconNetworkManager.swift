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

    /// Creates the cache object for storing the app icon.
    let iconCache = NSCache<NSString, PlatformImage>()

    private init() {}

    /// Fetches the app icon URL string for a given app.
    /// - Parameter app: The app to retrieve the app icon for.
    /// - Returns: The string containing the URL of the app's icon.
    func fetchURL(for app: any AKApp) async -> String? {
        let cacheKeySuffix = StorePlatform.current.pageQueryValue ?? "generic"
        let cacheKey = NSString(string: "\(app.id)-\(cacheKeySuffix)")

        if let cachedImageURL = cache.object(forKey: cacheKey) as? String {
            return cachedImageURL
        }

        let appIconURL: String?

        if let platformSpecificURL = await fetchPlatformSpecificURL(for: app) {
            appIconURL = platformSpecificURL
        } else {
            appIconURL = await fetchLookupURL(for: app)
        }

        if let appIconURL {
            cache.setObject(NSString(string: appIconURL), forKey: cacheKey)
            return appIconURL
        }

        return nil
    }

    private func fetchPlatformSpecificURL(for app: any AKApp) async -> String? {
        let platforms = StorePlatform.current == .generic ? [StorePlatform.generic] : [StorePlatform.current, .generic]

        for platform in platforms {
            guard let url = appStorePageURL(for: app.id, platform: platform) else {
                continue
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                if let html = String(data: data, encoding: .utf8),
                   let appIconURL = appIconURL(from: html, appID: app.id, platform: platform) {
                    return appIconURL
                }
            } catch {
                continue
            }
        }

        return nil
    }

    private func appStorePageURL(for appID: String, platform: StorePlatform) -> URL? {
        let baseURL = "https://apps.apple.com/us/app/id\(appID)"

        if let pageQueryValue = platform.pageQueryValue {
            return URL(string: "\(baseURL)?platform=\(pageQueryValue)")
        }

        return URL(string: baseURL)
    }

    private func appIconURL(from html: String, appID: String, platform: StorePlatform) -> String? {
        let escapedAppID = NSRegularExpression.escapedPattern(for: appID)
        let escapedPlatformContext = NSRegularExpression.escapedPattern(for: platform.platformContext)

        let pattern = "\"lockup\":\\{\"\\$kind\":\"Lockup\",\"adamId\":\"\(escapedAppID)\".*?\"template\":\"([^\"]+)\".*?\"targetId\":\"\(escapedAppID)\".*?\"platformContext\":\"\(escapedPlatformContext)\""

        guard let regularExpression = try? NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators]),
              let match = regularExpression.firstMatch(in: html, range: NSRange(html.startIndex..., in: html)),
              let templateRange = Range(match.range(at: 1), in: html) else {
            return nil
        }

        let template = String(html[templateRange])

        return template
            .replacing("{w}", with: "512")
            .replacing("{h}", with: "512")
            .replacing("{c}", with: "bb")
            .replacing("{f}", with: "jpg")
    }

    private func fetchLookupURL(for app: any AKApp) async -> String? {
        let urlString = "https://itunes.apple.com/lookup?id=\(app.id)"

        guard let url = URL(string: urlString) else {
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(AppResponse.self, from: data)

            return decodedResponse.results.first?.appIcon
        } catch {
            return nil
        }
    }

    private enum StorePlatform: Equatable {
        case generic
        case macOS
        case tvOS
        case visionOS
        case watchOS

        var pageQueryValue: String? {
            switch self {
            case .generic:
                nil
            case .macOS:
                "mac"
            case .tvOS:
                "tv"
            case .visionOS:
                "vision"
            case .watchOS:
                "watch"
            }
        }

        var platformContext: String {
            switch self {
            case .generic:
                "iphone"
            case .macOS:
                "mac"
            case .tvOS:
                "tv"
            case .visionOS:
                "vision"
            case .watchOS:
                "watch"
            }
        }

        static var current: StorePlatform {
            #if os(tvOS)
            .tvOS
            #elseif os(watchOS)
            .watchOS
            #elseif os(visionOS)
            .visionOS
            #elseif os(macOS)
            .macOS
            #else
            .generic
            #endif
        }
    }

    /// A custom struct containing the results from the request.
    struct AppResponse: Codable {
        let results: [AppResult]
    }

    /// A custom struct containing the appIcon URL string in the result.
    struct AppResult: Codable {
        let appIcon: String?

        enum CodingKeys: String, CodingKey {
            case appIcon = "artworkUrl512"
        }
    }
}
