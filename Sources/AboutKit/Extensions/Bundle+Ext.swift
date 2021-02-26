//
//  Bundle+Ext.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

import Foundation

extension Bundle {
    /// Returns a string with the current app version number e.g. 1.0.
    var versionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    /// Returns a string with the current app build number e.g. 1.
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}
