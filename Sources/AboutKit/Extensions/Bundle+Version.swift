//
//  Bundle+Version.swift
//  AboutKit
//
//  Created by Adam Foot on 02/08/2023.
//

import Foundation

extension Bundle {

    /// Returns a `String` with the current app version number, e.g. 1.0.
    var versionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    /// Returns a `String` with the current app build number, e.g. 1.
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}
