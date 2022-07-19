//
//  AKOtherApp.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

/// A custom struct of data to create a promoted other app list item.
public struct AKOtherApp: AKApp, Identifiable {
    /// The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing for the app. This should be in the format 123456789.
    public let id: String

    /// The app name string.
    public let name: String

    /// An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    public let appIcon: UIImage?

    /// Initializes a custom struct of data to create a promoted other app list item.
    /// - Parameters:
    ///   - id: The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing for the app. This should be in the format 123456789.
    ///   - name: The app name string.
    ///   - appIcon: An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    public init(
        id: String,
        name: String,
        appIcon: UIImage? = nil
    ) {
        self.id = id
        self.name = name
        self.appIcon = appIcon
    }
    
    static let example = AKOtherApp(
        id: "987654321",
        name: "Other App"
    )
}
