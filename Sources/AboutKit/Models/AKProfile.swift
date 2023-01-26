//
//  AKProfile.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

public struct AKProfile {
    public let username: String
    public let platform: AKProfilePlatform
    public let displayMode: AKProfileDisplayMode

    public init(
        username: String,
        platform: AKProfilePlatform,
        displayMode: AKProfileDisplayMode = .combined
    ) {
        self.username = username.replacingOccurrences(of: "@", with: "")
        self.platform = platform
        self.displayMode = displayMode
    }

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

    var displayUsername: String {
        return "@\(username)"
    }

    var url: URL {
        switch platform {
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
        case .tikTok:
            return URL(string: "https://tiktok.com/@\(username)")!
        case .twitter:
            return URL(string: "https://twitter.com/\(username)")!
        }
    }
}
