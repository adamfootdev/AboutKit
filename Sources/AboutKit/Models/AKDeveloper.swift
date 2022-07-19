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

    /// An optional Twitter profile handle string for the developer.
    public let twitterHandle: String?

    /// Initializes a custom struct of data pertaining to developer of an app.
    /// - Parameters:
    ///   - id: The developer ID string for the given developer. This can be found by locating the App Store URL for the developer. This should be in the format 123456789.
    ///   - name: The name of the developer as a string.
    ///   - twitterHandle: An optional Twitter profile handle string for the developer.
    public init(id: String, name: String, twitterHandle: String?) {
        self.id = id
        self.name = name
        self.twitterHandle = twitterHandle?.replacingOccurrences(of: "@", with: "")
    }

    /// The App Store URL for the developer page based on the ID.
    public var appStoreURL: URL {
        URL(string: "https://apps.apple.com/developer/id\(id)")!
    }
    
    static let example = AKDeveloper(
        id: "123456789",
        name: "App Developer",
        twitterHandle: "AppDeveloper"
    )
}
