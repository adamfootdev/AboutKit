//
//  LinkedInProfileType.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

public enum LinkedInProfileType {
    case company
    case user

    var urlInfo: String {
        switch self {
        case .company:
            return "company"
        case .user:
            return "in"
        }
    }
}
