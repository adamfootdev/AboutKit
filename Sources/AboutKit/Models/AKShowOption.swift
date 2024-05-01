//
//  AKShowOption.swift
//  AboutKit
//
//  Created by Adam Foot on 29/09/2023.
//

import Foundation

/// A custom enum used to indicate whether a feature should be shown or hidden.
public enum AKShowOption: Sendable {
    case always, testFlightOnly, appStoreOnly, never

    var isVisible: Bool {
        switch self {
        case .always:
            return true
        case .testFlightOnly:
            return Bundle.main.userType == .testFlight
        case .appStoreOnly:
            return Bundle.main.userType == .appStore
        case .never:
            return false
        }
    }
}
