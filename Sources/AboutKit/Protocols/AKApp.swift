//
//  AKApp.swift
//  AboutKit
//
//  Created by Adam Foot on 19/07/2022.
//

import SwiftUI

public protocol AKApp: Identifiable, Sendable {
    var id: String { get }
    var name: String { get }
    var appIcon: PlatformImage? { get }
}

public extension AKApp {
    /// The App Store URL of the app based on its ID.
    var appStoreURL: URL {
        #if os(macOS)
        URL(string: "macappstore://apps.apple.com/app/id\(id)")!
        #else
        URL(string: "https://apps.apple.com/app/id\(id)")!
        #endif
    }

    /// The App Store URL of the app based on its ID for sharing.
    var appStoreShareURL: URL {
        URL(string: "https://apps.apple.com/app/id\(id)")!
    }

    /// The App Store URL to review the app based on its ID.
    var appStoreReviewURL: URL {
        #if os(macOS)
        URL(string: "macappstore://apps.apple.com/app/id\(id)?action=write-review")!
        #else
        URL(string: "https://apps.apple.com/app/id\(id)?action=write-review")!
        #endif
    }
}
