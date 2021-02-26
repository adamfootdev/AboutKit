//
//  AKFeatureItem.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

/// A custom struct of data to create a new featured item to be shown in a list.
public struct AKFeatureItem: Identifiable {
    /// A unique ID set by the system so that the struct conforms to Identifiable.
    public let id = UUID()

    /// The title string for the item.
    public let title: String

    /// The description string for the item.
    public let description: String

    /// The system image name string for the item.
    public let systemImage: String

    /// The image tint color for the system image.
    public let imageTint: Color

    /// Initializes a custom struct of data to create a new featured item to be shown in a list.
    /// - Parameters:
    ///   - title: The title string for the item.
    ///   - description: The description string for the item.
    ///   - systemImage: The system image name string for the item.
    ///   - imageTint: The image tint color for the system image.
    public init(title: String, description: String, systemImage: String, imageTint: Color = .accentColor) {
        self.title = title
        self.description = description
        self.systemImage = systemImage
        self.imageTint = imageTint
    }
    
    static let example = AKFeatureItem(
        title: "Feature",
        description: "This is a feature description.",
        systemImage: "checkmark.circle"
    )
}
