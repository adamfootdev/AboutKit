//
//  LocalizedStrings.swift
//  AboutKit
//
//  Created by Adam Foot on 25/02/2021.
//

import Foundation

/// Provides a quick way to access localized strings stored in the package bundle.
enum LocalizedStrings {
    static let email = String(localized: "Email", bundle: .module)
    static let website = String(localized: "Website", bundle: .module)
    static let shareApp = String(localized: "Share App", bundle: .module)
    static let writeReview = String(localized: "Write Review", bundle: .module)
    static let privacyPolicy = String(localized: "Privacy Policy", bundle: .module)
    static let termsOfUse = String(localized: "Terms Of Use", bundle: .module)
    static let acknowledgements = String(localized: "Acknowledgements", bundle: .module)

    static let contactDeveloper = String(localized: "Contact Developer…", bundle: .module)
    static let openWebsite = String(localized: "Open Website…", bundle: .module)
    static let viewProfile = String(localized: "View Profile…", bundle: .module)
    static let share = String(localized: "Share…", bundle: .module)
    static let review = String(localized: "Review…", bundle: .module)
    static let viewPrivacyPolicy = String(localized: "View Privacy Policy…", bundle: .module)
    static let viewTermsOfUse = String(localized: "View Terms of Use…", bundle: .module)
    static let viewAcknowledgements = String(localized: "View Acknowledgements…", bundle: .module)

    static let otherApps = String(localized: "Other Apps", bundle: .module)
    static let view = String(localized: "View", bundle: .module)
    static let viewAllApps = String(localized: "View all Apps", bundle: .module)
    static let viewMac = String(localized: "View…", bundle: .module)

    static let about = String(localized: "About", bundle: .module)
    static let done = String(localized: "Done", bundle: .module)

    static let people = String(localized: "People", bundle: .module)
    static let frameworks = String(localized: "Frameworks", bundle: .module)
    static let links = String(localized: "Links", bundle: .module)
    static let profiles = String(localized: "Profiles", bundle: .module)
    static let details = String(localized: "Details", bundle: .module)
    static let productPage = String(localized: "Product Page", bundle: .module)
    static let repository = String(localized: "Repository", bundle: .module)
    static let compliance = String(localized: "Compliance", bundle: .module)
}
