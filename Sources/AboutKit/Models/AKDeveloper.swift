//
//  AKDeveloper.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import Foundation

/// A custom struct of data pertaining to developer of an app.
public struct AKDeveloper {
    /// The developer ID string for the given developer. This can be found by locating the App Store URL for the developer. This should be in the format 123456789.
    public let id: String

    /// The name of the developer as a string.
    public let name: String

    /// A list of social media pages for the developer.
    public let profiles: [AKProfile]

    /// Initializes a custom struct of data pertaining to developer of an app.
    /// - Parameters:
    ///   - id: The developer ID string for the given developer. This can be found by locating the App Store URL for the developer. This should be in the format 123456789.
    ///   - name: The name of the developer as a string.
    ///   - profiles: A list of social media pages for the developer.
    public init(id: String, name: String, profiles: [AKProfile]) {
        self.id = id
        self.name = name
        self.profiles = profiles
    }

    /// The App Store URL for the developer page based on the ID.
    public var appStoreURL: URL {
        URL(string: "https://apps.apple.com/developer/id\(id)")!
    }
    
    static let example = AKDeveloper(
        id: "123456789",
        name: "App Developer",
        profiles: [
            .init(username: "appdeveloper", platform: .twitter)
        ]
    )
}
