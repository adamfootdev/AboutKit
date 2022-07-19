//
//  LocalizedStrings.swift
//  AboutKit
//
//  Created by Adam Foot on 25/02/2021.
//

import Foundation

/// Provides a quick way to access localized strings stored in the package bundle.
enum LocalizedStrings {
    static let continueButton = String(localized: "Continue", bundle: .module)

    static let email = String(localized: "Email", bundle: .module)
    static let website = String(localized: "Website", bundle: .module)
    static let shareApp = String(localized: "Share App", bundle: .module)
    static let writeReview = String(localized: "Write Review", bundle: .module)
    static let privacyPolicy = String(localized: "Privacy Policy", bundle: .module)
    static let termsOfUse = String(localized: "Terms Of Use", bundle: .module)

    static let otherApps = String(localized: "Other Apps", bundle: .module)
    static let view = String(localized: "VIEW", bundle: .module)
    static let viewAll = String(localized: "View all Apps", bundle: .module)

    static let done = String(localized: "Done", bundle: .module)
    static let about = String(localized: "About", bundle: .module)

    static let welcomeTo = String(localized: "Welcome to", bundle: .module)
}
