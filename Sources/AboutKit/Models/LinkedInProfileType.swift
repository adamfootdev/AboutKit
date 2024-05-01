//
//  LinkedInProfileType.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

/// A custom enum related to the type of profile a LinkedIn account is.
public enum LinkedInProfileType: Sendable {
    case company, user

    /// A `String` to be used in the LinkedIn profile URL.
    var urlInfo: String {
        switch self {
        case .company:
            return "company"
        case .user:
            return "in"
        }
    }
}
