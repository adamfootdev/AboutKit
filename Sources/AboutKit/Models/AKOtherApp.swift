//
//  AKOtherApp.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import Foundation

/// A custom struct of data to create a promoted other app list item.
public struct AKOtherApp: Identifiable {
    /// The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing for the app. This should be in the format 123456789.
    public let id: String

    /// The app name string.
    public let name: String

    /// Initializes a custom struct of data to create a promoted other app list item.
    /// - Parameters:
    ///   - id: The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing for the app. This should be in the format 123456789.
    ///   - name: The app name string.
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    static let example = AKOtherApp(
        id: "987654321",
        name: "Other App"
    )
}
