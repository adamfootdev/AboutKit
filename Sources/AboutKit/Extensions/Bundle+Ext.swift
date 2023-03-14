//
//  Bundle+Ext.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

#if os(macOS)
import AppKit
import IOKit
#else
import UIKit
#endif

extension Bundle {
    /// Returns a string with the current app version number e.g. 1.0.
    var versionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    /// Returns a string with the current app build number e.g. 1.
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    /// Returns a custom enum containing the environment that the current user is using.
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

    #if os(iOS)
    /// A string containing debug details about the current app.
    var debugDetails: String {
        "\n\n\nDEBUG DETAILS\n\nApp Version: \(versionNumber) (\(buildNumber))\nOS Version: \(UIDevice.current.systemVersion)\nDevice: \(UIDevice.current.deviceType)\nEnvironment: \(userType.title)"
    }

    #elseif os(macOS)

    /// Returns a string containing the identifier of the current device e.g. MacBook Pro 13,1
    var deviceType: String {
        let service = IOServiceGetMatchingService(
            kIOMainPortDefault,
            IOServiceMatching("IOPlatformExpertDevice")
        )

        var modelIdentifier: String?

        if let modelData = IORegistryEntryCreateCFProperty(service, "model" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? Data {
            modelIdentifier = String(data: modelData, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters)
        }

        IOObjectRelease(service)

        return modelIdentifier ?? "Unknown"
    }

    /// A string containing debug details about the current app.
    var debugDetails: String {
        "\n\n\nDEBUG DETAILS\n\nApp Version: \(versionNumber) (\(buildNumber))\nOS Version: \(ProcessInfo.processInfo.operatingSystemVersionString)\nDevice: \(deviceType)\nEnvironment: \(userType.title)"
    }
    #endif
}
