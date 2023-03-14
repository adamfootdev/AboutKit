//
//  AKApp.swift
//  AboutKit
//
//  Created by Adam Foot on 19/07/2022.
//

import SwiftUI

public protocol AKApp {
    var id: String { get }
    var name: String { get }
    var appIcon: PlatformImage? { get }
}

public extension AKApp {
    /// The App Store URL of the app based on its ID.
    var appStoreURL: URL {
        URL(string: "https://apps.apple.com/app/id\(id)")!
    }

    /// The App Store URL to review the app based on its ID.
    var appStoreReviewURL: URL {
        URL(string: "https://apps.apple.com/app/id\(id)?action=write-review")!
    }
}
