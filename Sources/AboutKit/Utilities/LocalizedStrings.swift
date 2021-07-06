//
//  LocalizedStrings.swift
//  AboutKit
//
//  Created by Adam Foot on 25/02/2021.
//

import Foundation

/// Provides a quick way to access localized strings stored in the package bundle.
enum LocalizedStrings {
    static let continueButton = NSLocalizedString("Continue", bundle: .module, comment: "")

    static let email = NSLocalizedString("Email", bundle: .module, comment: "")
    static let website = NSLocalizedString("Website", bundle: .module, comment: "")
    static let shareApp = NSLocalizedString("Share App", bundle: .module, comment: "")
    static let writeReview = NSLocalizedString("Write Review", bundle: .module, comment: "")
    static let privacyPolicy = NSLocalizedString("Privacy Policy", bundle: .module, comment: "")

    static let otherApps = NSLocalizedString("Other Apps", bundle: .module, comment: "")
    static let view = NSLocalizedString("VIEW", bundle: .module, comment: "")
    static let viewAll = NSLocalizedString("View all Apps", bundle: .module, comment: "")

    static let done = NSLocalizedString("Done", bundle: .module, comment: "")
    static let about = NSLocalizedString("About", bundle: .module, comment: "")

    static let welcomeTo = NSLocalizedString("Welcome to", bundle: .module, comment: "")
}
