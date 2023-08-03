//
//  UserType.swift
//  AboutKit
//
//  Created by Adam Foot on 12/06/2021.
//

import Foundation

/// A custom enum containing the environment the current user is using.
enum UserType {
    case debug, testFlight, appStore

    /// Returns a `String` matching the environment.
    var title: String {
        switch self {
        case .debug:
            return "Debug"
        case .testFlight:
            return "TestFlight"
        case .appStore:
            return "App Store"
        }
    }
}
