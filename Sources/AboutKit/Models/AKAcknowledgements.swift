//
//  AKAcknowledgements.swift
//  AboutKit
//
//  Created by Adam Foot on 14/08/2023.
//

import Foundation

/// A custom struct containing details about the acknowledgements for the app.
public struct AKAcknowledgements {
    
    /// An `Optional` array of `AKPersonAcknowledgement` that contains details about the people to acknowledge in developing the app.
    public let people: [AKPersonAcknowledgement]?

    /// An `Optional` array of `AKFrameworkAcknowledgement` that contains details about the frameworks used in the app.
    public let frameworks: [AKFrameworkAcknowledgement]?
    
    /// Initalizes a custom struct containing details about the acknowledgements for the app.
    /// - Parameters:
    ///   - people: An `Optional` array of `AKPersonAcknowledgement` that contains details about the people to acknowledge in developing the app.
    ///   - frameworks: An `Optional` array of `AKFrameworkAcknowledgement` that contains details about the frameworks used in the app.
    public init(
        people: [AKPersonAcknowledgement]?,
        frameworks: [AKFrameworkAcknowledgement]?

    ) {
        self.people = people
        self.frameworks = frameworks
    }

    /// An example `AKAcknowledgements` to be used in SwiftUI previews.
    public static let example = AKAcknowledgements(
        people: [.example],
        frameworks: [.example]
    )
}
