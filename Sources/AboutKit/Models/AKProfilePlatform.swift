//
//  AKProfilePlatform.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

public enum AKProfilePlatform {
    case facebook
    case instagram
    case linkedIn(profileType: LinkedInProfileType)
    case mastodon(instance: String)
    case reddit
    case pinterest
    case snapchat
    case tikTok
    case twitter

    var name: String {
        switch self {
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
        case .tikTok:
            return "TikTok"
        case .twitter:
            return "Twitter"
        }
    }

    var imageName: String {
        switch self {
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
        case .tikTok:
            return "tiktok"
        case .twitter:
            return "twitter"
        }
    }
}
