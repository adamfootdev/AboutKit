//
//  AKFrameworkAcknowledgement.swift
//  AboutKit
//
//  Created by Adam Foot on 14/08/2023.
//

import Foundation

/// A custom struct containing details about the frameworks used in the app.
public struct AKFrameworkAcknowledgement {

    /// A `String` containing the frameworkʼs name.
    public let name: String

    /// An `Optional<String>` containing details about the framework such as licence information.
    public let details: String?

    /// An `Optional` array of `AKFrameworkAcknowledgementLink` containing links related to the framework.
    public let links: [AKFrameworkAcknowledgementLink]?
    
    /// Initializes a custom struct containing details about the frameworks used in the app.
    /// - Parameters:
    ///   - name: A `String` containing the frameworkʼs name.
    ///   - details: An `Optional<String>` containing details about the framework such as licence information.
    ///   - links: An `Optional` array of `AKFrameworkAcknowledgementLink` containing links related to the framework.
    public init(
        _ name: String,
        details: String?,
        links: [AKFrameworkAcknowledgementLink]?
    ) {
        self.name = name
        self.details = details
        self.links = links
    }

    /// An example `AKFrameworkAcknowledgement` to be used in SwiftUI previews.
    public static let example = AKFrameworkAcknowledgement(
        "AboutKit",
        details: "Some details here…",
        links: [.repository(URL(string: "https://github.com/adamfootdev/AboutKit")!)]
    )
}
