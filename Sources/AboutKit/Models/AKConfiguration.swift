//
//  AKConfiguration.swift
//  AboutKit
//
//  Created by Adam Foot on 29/09/2023.
//

import Foundation

/// A custom struct containing details for AboutKit.
public struct AKConfiguration {
    
    /// A custom struct of type `AKMyApp` containing details about the current app.
    public let app: AKMyApp

    /// An array of `AKOtherApp` that contains details about other apps the developer owns.
    public let otherApps: [AKOtherApp]
    
    /// Indicates whether to show the Share App option.
    public let showShareApp: AKShowOption

    /// Indicates whether to show the Write Review option.
    public let showWriteReview: AKShowOption

    /// The ordered sections displayed in the AboutKit form.
    public let sections: [AKSection]

    /// Creates attachments immediately before AboutKit opens the support-email composer.
    /// Return `nil` when no attachments are available. Invalid attachments are ignored.
    public let emailAttachments: (@MainActor () async -> [AKEmailAttachment]?)?

    /// Initializes a new `AKConfiguration` struct which contains details about the
    /// current app and other apps.
    /// - Parameters:
    ///   - app: A custom struct of type `AKMyApp` containing details about the current app.
    ///   - otherApps: An array of `AKOtherApp` that contains details about other apps the developer owns.
    ///   - showShareApp: Indicates whether to show the Share App option. Defaults to `.always`.
    ///   - showWriteReview: Indicates whether to show the Write Review option. Defaults to `.always`.
    ///   - sections: The ordered sections displayed in the AboutKit form. Defaults to `AKSection.defaultOrder`.
    ///   - emailAttachments: An optional asynchronous closure that creates support-email attachments.
    public init(
        app: AKMyApp,
        otherApps: [AKOtherApp],
        showShareApp: AKShowOption = .always,
        showWriteReview: AKShowOption = .always,
        sections: [AKSection] = AKSection.defaultOrder,
        emailAttachments: (@MainActor () async -> [AKEmailAttachment]?)? = nil
    ) {
        self.app = app
        self.otherApps = otherApps
        self.showShareApp = showShareApp
        self.showWriteReview = showWriteReview
        self.sections = sections
        self.emailAttachments = emailAttachments
    }

    /// An example `AKConfiguration` to be used in SwiftUI previews.
    @MainActor
    static let example = AKConfiguration(
        app: .example,
        otherApps: [.example],
        showShareApp: .always,
        showWriteReview: .always
    )
}
