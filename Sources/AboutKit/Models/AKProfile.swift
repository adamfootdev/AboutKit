//
//  AKProfile.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

/// A custom struct containing details about a social media platform profile.
public struct AKProfile: Identifiable, Hashable, Sendable {

    /// A `String` containing the username for the profile.
    public let username: String

    /// The platform for the profile.
    public let platform: AKProfilePlatform

    /// Controls the visibility of the username or platform name.
    public let displayMode: AKProfileDisplayMode
    
    /// Creates a new social media platform profile.
    /// - Parameters:
    ///   - username: A `String` containing the username for the profile.
    ///   - platform: The platform for the profile.
    ///   - displayMode: Controls the visibility of the username or platform name. Defaults to `.combined`.
    public init(
        username: String,
        platform: AKProfilePlatform,
        displayMode: AKProfileDisplayMode = .combined
    ) {
        self.username = username.replacingOccurrences(of: "@", with: "")
        self.platform = platform
        self.displayMode = displayMode
    }
    
    /// The ID `String` for the profile.
    public var id: String {
        "\(username)-\(platform.name)"
    }
    
    /// A `String` containing the display title of the profile.
    var title: String {
        switch displayMode {
        case .combined:
            return "\(platform.name) (\(displayUsername))"
        case .platformOnly:
            return platform.name
        case .usernameOnly:
            return displayUsername
        case .custom(let value):
            return value
        }
    }
    
    /// A `String` containing the username to be displayed.
    var displayUsername: String {
        return "@\(username)"
    }
    
    /// The `URL` to open the profile on the platform.
    var url: URL {
        switch platform {
        case .bluesky:
            return URL(string: "https://bsky.app/profile/\(username)")!
        case .facebook:
            return URL(string: "https://facebook.com/\(username)")!
        case .instagram:
            return URL(string: "https://instagram.com/\(username)")!
        case .linkedIn(let profileType):
            return URL(string: "https://linkedin.com/\(profileType.urlInfo)/\(username)")!
        case .mastodon(let instance):
            return URL(string: "https://\(instance)/@\(username)")!
        case .pinterest:
            return URL(string: "https://pinterest.co.uk/\(username)")!
        case .reddit:
            return URL(string: "https://reddit.com/user/\(username)")!
        case .snapchat:
            return URL(string: "https://snapchat.com/add/\(username)")!
        case .threads:
            return URL(string: "https://www.threads.net/@\(username)")!
        case .tikTok:
            return URL(string: "https://tiktok.com/@\(username)")!
        case .twitter:
            return URL(string: "https://twitter.com/\(username)")!
        case .x:
            return URL(string: "https://x.com/\(username)")!
            
        }
    }

    /// An example `AKProfile` to be used in SwiftUI previews.
    public static let example = AKProfile(username: "ExampleApp", platform: .reddit)
}
