//
//  AKApp.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

/// A custom struct of data pertaining to the specified app.
public struct AKMyApp: AKApp {
    /// The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing
    /// for the app. This should  be in the format 123456789.
    public let id: String

    /// The app name string.
    public let name: String

    /// An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    public let appIcon: PlatformImage?

    /// A custom struct container details about the developer of the app.
    public let developer: AKDeveloper

    /// The email address to contact the app's support as a string.
    public let email: String

    /// A list of social media pages for the app.
    public let profiles: [AKProfile]

    /// A URL string directing to the app's website.
    public let websiteURL: String

    /// An optional URL string directing to the privacy policy for the app.
    public let privacyPolicyURL: String?

    /// An optional URL string directing to the terms of use for the app.
    public let termsOfUseURL: String?

    /// Initializes a custom struct of data pertaining to the specified app.
    /// - Parameters:
    ///   - id: The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing
    ///   for the app. This should  be in the format 123456789.
    ///   - name: The app name string.
    ///   - email: The email address to contact the app's support as a string.
    ///   - appIcon: An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    ///   - developer: A custom struct container details about the developer of the app.
    ///   - profiles: A list of social media pages for the app.
    ///   - websiteURL: A URL string directing to the app's website.
    ///   - privacyPolicyURL: An optional URL string directing to the privacy policy for the app.
    ///   - termsOfUseURL: An optional URL string directing to the terms of use for the app.
    public init(
        id: String,
        name: String,
        appIcon: PlatformImage?,
        developer: AKDeveloper,
        email: String,
        profiles: [AKProfile],
        websiteURL: String,
        privacyPolicyURL: String?,
        termsOfUseURL: String?
    ) {
        self.id = id
        self.name = name
        self.appIcon = appIcon
        self.developer = developer
        self.email = email
        self.profiles = profiles
        self.websiteURL = websiteURL
        self.privacyPolicyURL = privacyPolicyURL
        self.termsOfUseURL = termsOfUseURL
    }

    static let example = AKMyApp(
        id: "123456789",
        name: "Sample",
        appIcon: nil,
        developer: AKDeveloper.example,
        email: "sampleapp@example.com",
        profiles: [
            .init(username: "exampleapp", platform: .twitter)
        ],
        websiteURL: "https://www.example.com",
        privacyPolicyURL: "https://www.example.com/privacy-policy",
        termsOfUseURL: "https://www.example.com/terms-of-use"
    )
}
