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

@MainActor
struct AboutKit {

    private init() {}

    #if os(macOS) || targetEnvironment(macCatalyst)

    /// Returns a `String` containing the identifier of the current device, e.g. MacBookPro13,1
    private static let deviceType: String = {
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
    }()

    /// A `String` containing debug details about the current app.
    static let debugDetails: String = {
        let versionNumber = Bundle.main.versionNumber
        let buildNumber = Bundle.main.buildNumber
        let versionDetails = "App Version: \(versionNumber) (\(buildNumber))"

        let osDetails = "OS Version: \(ProcessInfo.processInfo.operatingSystemVersionString)"
        let deviceDetails = "Device: \(deviceType)"
        let environmentDetails = "Environment: \(Bundle.main.userType.title)"

        return "\n\n\nDEBUG DETAILS\n\n\(versionDetails)\n\(osDetails)\n\(deviceDetails)\n\(environmentDetails)"
    }()

    #elseif os(iOS) || os(visionOS)

    /// Returns a `String` containing the identifier of the current device, e.g. iPhone17,1
    private static let deviceType: String = {
        if ProcessInfo().isiOSAppOnMac {
            var size = 0
            let key = "hw.model"
            sysctlbyname(key, nil, &size, nil, 0)
            var value = [CChar](repeating: 0,  count: size)
            sysctlbyname(key, &value, &size, nil, 0)
            return String(cString: value, encoding: .utf8) ?? "Mac"
        } else {
            return UIDevice.current.deviceType
        }
    }()

    /// A `String` containing debug details about the current app.
    static let debugDetails: String = {
        let versionNumber = Bundle.main.versionNumber
        let buildNumber = Bundle.main.buildNumber
        let versionDetails = "App Version: \(versionNumber) (\(buildNumber))"

        let osDetails = "OS Version: \(ProcessInfo.processInfo.operatingSystemVersionString)"
        let deviceDetails = "Device: \(deviceType)"
        let environmentDetails = "Environment: \(Bundle.main.userType.title)"

        return "\n\n\nDEBUG DETAILS\n\n\(versionDetails)\n\(osDetails)\n\(deviceDetails)\n\(environmentDetails)"
    }()

    #endif
}
