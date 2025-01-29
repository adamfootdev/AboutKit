//
//  AKProfilePlatform.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

/// A custom enum used for a social profile platform.
public enum AKProfilePlatform: Hashable, Sendable {
    case bluesky
    case facebook
    case instagram
    case linkedIn(profileType: LinkedInProfileType)
    case mastodon(instance: String)
    case reddit
    case pinterest
    case snapchat
    case threads
    case tikTok
    case twitter
    case x

    /// A `String` containing the name of the platform.
    var name: String {
        switch self {
        case .bluesky:
            return "Bluesky"
        case .facebook:
            return "Facebook"
        case .instagram:
            return "Instagram"
        case .linkedIn(_):
            return "LinkedIn"
        case .mastodon(_):
            return "Mastodon"
        case .pinterest:
            return "Pinterest"
        case .reddit:
            return "Reddit"
        case .snapchat:
            return "Snapchat"
        case .threads:
            return "Threads"
        case .tikTok:
            return "TikTok"
        case .twitter:
            return "Twitter"
        case .x:
            return "X"
        }
    }
    
    /// A `String` containing the name of the image to use for the platform.
    var imageName: String {
        switch self {
        case .bluesky:
            return "bluesky"
        case .facebook:
            return "facebook"
        case .instagram:
            return "instagram"
        case .linkedIn(_):
            return "linkedin"
        case .mastodon(_):
            return "mastodon"
        case .pinterest:
            return "pinterest"
        case .reddit:
            return "reddit"
        case .snapchat:
            return "snapchat"
        case .threads:
            return "threads"
        case .tikTok:
            return "tiktok"
        case .twitter:
            return "twitter"
        case .x:
            return "x"
        }
    }
}
