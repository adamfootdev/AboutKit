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

struct AboutKit {
    
    private init() {}

    #if os(iOS) || os(visionOS)
    /// A `String` containing debug details about the current app.
    static var debugDetails: String {
        let versionNumber = Bundle.main.versionNumber
        let buildNumber = Bundle.main.buildNumber
        let versionDetails = "App Version: \(versionNumber)(\(buildNumber))"

        let osDetails = "OS Version: \(UIDevice.current.systemVersion)"
        let deviceDetails = "Device: \(UIDevice.current.deviceType)"
        let environmentDetails = "Environment: \(Bundle.main.userType.title)"

        return "\n\n\nDEBUG DETAILS\n\n\(versionDetails)\n\(osDetails)\n\(deviceDetails)\n\(environmentDetails)"
    }

    #elseif os(macOS)

    /// Returns a `String` containing the identifier of the current device, e.g. MacBook Pro 13,1
    private static var deviceType: String {
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

    /// A `String` containing debug details about the current app.
    static var debugDetails: String {
        let versionNumber = Bundle.main.versionNumber
        let buildNumber = Bundle.main.buildNumber
        let versionDetails = "App Version: \(versionNumber)(\(buildNumber))"

        let osDetails = "OS Version: \(ProcessInfo.processInfo.operatingSystemVersionString)"
        let deviceDetails = "Device: \(deviceType)"
        let environmentDetails = "Environment: \(Bundle.main.userType.title)"

        return "\n\n\nDEBUG DETAILS\n\n\(versionDetails)\n\(osDetails)\n\(deviceDetails)\n\(environmentDetails)"
    }
    #endif
}
