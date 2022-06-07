//
//  AKApp.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

/// A custom struct of data pertaining to the specified app.
public struct AKApp {
    /// The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing
    /// for the app. This should  be in the format 123456789.
    public let id: String

    /// The app name string.
    public let name: String

    /// An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    public let appIcon: UIImage?

    /// A custom struct container details about the developer of the app.
    public let developer: AKDeveloper

    /// The email address to contact the app's support as a string.
    public let email: String

    /// An optional Twitter profile handle string for the app. This should be in the format SampleApp without the @.
    public let twitterHandle: String?

    /// A URL string directing to the app's website.
    public let websiteURL: String

    /// An optional URL string directing to the privacy policy for the app.
    public let privacyPolicyURL: String?

    /// Initializes a custom struct of data pertaining to the specified app.
    /// - Parameters:
    ///   - id: The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing
    ///   for the app. This should  be in the format 123456789.
    ///   - name: The app name string.
    ///   - email: The email address to contact the app's support as a string.
    ///   - appIcon: An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    ///   - developer: A custom struct container details about the developer of the app.
    ///   - twitterHandle: An optional Twitter profile handle string for the app. This should be in the format SampleApp without the @.
    ///   - privacyPolicyURL: An optional URL string directing to the privacy policy for the app.
    ///   - websiteURL: A URL string directing to the app's website.
    public init(
        id: String,
        name: String,
        appIcon: UIImage?,
        developer: AKDeveloper,
        email: String,
        twitterHandle: String?,
        websiteURL: String,
        privacyPolicyURL: String?
    ) {
        self.id = id
        self.name = name
        self.appIcon = appIcon
        self.developer = developer
        self.email = email
        self.twitterHandle = twitterHandle
        self.websiteURL = websiteURL
        self.privacyPolicyURL = privacyPolicyURL
    }

    /// The App Store URL of the app based on its ID.
    public var appStoreURL: URL {
        URL(string: "https://apps.apple.com/app/id\(id)")!
    }

    /// The App Store URL to review the app based on its ID.
    public var appStoreReviewURL: URL {
        URL(string: "https://apps.apple.com/app/id\(id)?action=write-review")!
    }
    
    static let example = AKApp(
        id: "123456789",
        name: "Sample",
        appIcon: nil,
        developer: AKDeveloper.example,
        email: "sampleapp@example.com",
        twitterHandle: "SampleApp",
        websiteURL: "https://www.example.com",
        privacyPolicyURL: "https://www.example.com/privacy-policy"
    )
}
