//
//  Bundle+User.swift
//  AboutKit
//
//  Created by Adam Foot on 02/08/2023.
//

import Foundation

extension Bundle {

    /// Returns the `UserType` depending on the current environment that the user is using.
    var userType: UserType {
        #if DEBUG
        return .debug
        #else
        if appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
            return .testFlight
        } else {
            return .appStore
        }
        #endif
    }
}
