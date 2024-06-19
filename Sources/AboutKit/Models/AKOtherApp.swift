//
//  AKOtherApp.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

/// A custom struct of data to create a promoted other app list item.
public struct AKOtherApp: AKApp, Sendable {

    /// The app ID `String` for the given app. This can be found in App Store Connect or the URL of the App Store
    /// listing for the app. This should be in the format 123456789.
    public let id: String

    /// A `String` containing the app's name.
    public let name: String

    /// An `Optional<PlatformImage>` containing the app icon.
    /// If an image is not specified, the app icon will be fetched from the App Store.
    public let appIcon: PlatformImage?

    /// Initializes a custom struct of data to create a promoted other app list item.
    /// - Parameters:
    ///   - id: The app ID `String` for the given app. This can be found in App Store Connect or the URL of the App Store
    ///   listing for the app. This should be in the format 123456789.
    ///   This should be in the format 123456789.
    ///   - name: A `String` containing the app's name.
    ///   - appIcon: An `Optional<PlatformImage>` containing the app icon.
    ///   If an image is not specified, the app icon will be fetched from the App Store.
    public init(
        id: String,
        name: String,
        appIcon: PlatformImage? = nil
    ) {
        self.id = id
        self.name = name
        self.appIcon = appIcon
    }

    /// An example `AKOtherApp` to be used in SwiftUI previews.
    public static let example = AKOtherApp(
        id: "987654321",
        name: "Other App"
    )
}
