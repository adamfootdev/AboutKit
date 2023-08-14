//
//  AKApp.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

/// A custom struct of containing details about the developerʼs app.
public struct AKMyApp: AKApp {

    /// The app ID `String` for the given app. This can be found in App Store Connect or the URL of the App Store
    /// listing for the app. This should be in the format 123456789.
    public let id: String

    /// A `String` containing the appʼs name.
    public let name: String

    /// An `Optional<PlatformImage>` containing the app icon.
    /// If an image is not specified, the app icon will be fetched from the App Store.
    public let appIcon: PlatformImage?

    /// A custom `AKDeveloper` struct containing details about the developer of the app.
    public let developer: AKDeveloper

    /// An `Optional<String>` containing the email address to contact the app's support.
    public let email: String?

    /// An `Optional<String>` containing the app's website.
    public let websiteURL: String?

    /// An array of `AKProfile` containing the social media pages for the app.
    public let profiles: [AKProfile]

    /// An `Optional<String>` containing the privacy policy for the app.
    public let privacyPolicyURL: String?

    /// An `Optional<String>` containing the terms of use for the app.
    public let termsOfUseURL: String?

    /// An `Optional<AKAcknowledgements>` struct containing all the acknowledgments for the app.
    public let acknowledgements: AKAcknowledgements?

    /// Initializes a custom struct of data pertaining to the specified app.
    /// - Parameters:
    ///   - id: The app ID `String` for the given app. This can be found in App Store Connect or the URL of the App Store
    ///   listing for the app. This should be in the format 123456789.
    ///   - name: A `String` containing the app's name.
    ///   - appIcon: An `Optional<PlatformImage>` containing the app icon.
    ///   If an image is not specified, the app icon will be fetched from the App Store.
    ///   - developer: A custom `AKDeveloper` struct containing details about the developer of the app.
    ///   - email: An `Optional<String>` containing the email address to contact the app's support.
    ///   - websiteURL: An `Optional<String>` containing the app's website.
    ///   - profiles: An `Optional` array of `AKProfile` containing the social media pages for the app.
    ///   - privacyPolicyURL: An `Optional<String>` containing the privacy policy for the app.
    ///   - termsOfUseURL: An `Optional<String>` containing the terms of use for the app.
    ///   - acknowledgements: An `Optional<AKAcknowledgement>` struct containing all the acknowledgments for the app. Defaults to `nil`.
    public init(
        id: String,
        name: String,
        appIcon: PlatformImage?,
        developer: AKDeveloper,
        email: String?,
        websiteURL: String?,
        profiles: [AKProfile]?,
        privacyPolicyURL: String?,
        termsOfUseURL: String?,
        acknowledgements: AKAcknowledgements? = nil
    ) {
        self.id = id
        self.name = name
        self.appIcon = appIcon
        self.developer = developer
        self.email = email
        self.websiteURL = websiteURL
        self.profiles = profiles ?? []
        self.privacyPolicyURL = privacyPolicyURL
        self.termsOfUseURL = termsOfUseURL
        self.acknowledgements = acknowledgements
    }

    /// An example `AKMyApp` to be used in SwiftUI previews.
    public static let example = AKMyApp(
        id: "123456789",
        name: "Example",
        appIcon: nil,
        developer: .example,
        email: "exampleapp@example.com",
        websiteURL: "https://www.example.com",
        profiles: [.example],
        privacyPolicyURL: "https://www.example.com/privacy-policy",
        termsOfUseURL: "https://www.example.com/terms-of-use",
        acknowledgements: .example
    )
}
