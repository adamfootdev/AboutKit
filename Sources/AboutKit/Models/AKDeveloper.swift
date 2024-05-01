//
//  AKDeveloper.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import Foundation

/// A custom struct containing details about the developer.
public struct AKDeveloper: Sendable {
    
    /// The developer ID `String` for the given app. This can be found by locating the App Store URL
    /// for the developer. This should be in the format 123456789.
    public let id: String

    /// A `String` containing the developerʼs name.
    public let name: String

    /// An array of `AKProfile` containing the social media pages for the developer.
    public let profiles: [AKProfile]

    /// Initializes a custom struct of data pertaining to developer of an app.
    /// - Parameters:
    ///   - id: The developer ID `String` for the given app. This can be found by locating the App Store URL
    ///   for the developer. This should be in the format 123456789.
    ///   - name: A `String` containing the developerʼs name.
    ///   - profiles: An `Optional` array of `AKProfile` containing the social media pages for the developer.
    public init(id: String, name: String, profiles: [AKProfile]?) {
        self.id = id
        self.name = name
        self.profiles = profiles ?? []
    }

    /// The App Store `URL` for the developer page based on the ID.
    public var appStoreURL: URL {
        URL(string: "https://apps.apple.com/developer/id\(id)")!
    }

    /// An example `AKDeveloper` to be used in SwiftUI previews.
    public static let example = AKDeveloper(
        id: "123456789",
        name: "App Developer",
        profiles: [
            .example
        ]
    )
}
