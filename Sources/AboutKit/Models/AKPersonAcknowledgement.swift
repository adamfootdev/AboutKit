//
//  AKPersonAcknowledgement.swift
//  AboutKit
//
//  Created by Adam Foot on 14/08/2023.
//

import Foundation

/// A custom struct containing details about the people to acknowledge in developing the app.
public struct AKPersonAcknowledgement: Sendable {

    /// A `String` containing the personʼs name.
    public let name: String

    /// An `Optional<String>` containing details about how they influenced the app.
    public let details: String?

    /// An `Optional` array of `AKProfile` containing their social media profiles.
    public let profiles: [AKProfile]?
    
    /// Initializes a custom struct containing details about the people to acknowledge in developing the app.
    /// - Parameters:
    ///   - name: A `String` containing the personʼs name.
    ///   - details: An `Optional<String>` containing details about how they influenced the app.
    ///   - profiles: An `Optional` array of `AKProfile` containing their social media profiles.
    public init(
        _ name: String,
        details: String?,
        profiles: [AKProfile]?
    ) {
        self.name = name
        self.details = details
        self.profiles = profiles
    }

    /// An example `AKPersonAcknowledgement` to be used in SwiftUI previews.
    public static let example = AKPersonAcknowledgement(
        "John Appleseed",
        details: "Some details here…",
        profiles: [.example]
    )
}
