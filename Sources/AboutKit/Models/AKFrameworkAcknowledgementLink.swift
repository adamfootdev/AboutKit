//
//  AKFrameworkAcknowledgementLink.swift
//  AboutKit
//
//  Created by Adam Foot on 14/08/2023.
//

import Foundation

/// A custom enum used for framework links.
public enum AKFrameworkAcknowledgementLink {
    case productPage(_ url: URL)
    case repository(_ url: URL)
    case compliance(_ url: URL)
    case custom(_ title: String, systemImage: String = "link", url: URL)
    
    /// A `String` containing the title of the link.
    var title: String {
        switch self {
        case .productPage(_):
            return LocalizedStrings.productPage
        case .repository(_):
            return LocalizedStrings.repository
        case .compliance(_):
            return LocalizedStrings.compliance
        case .custom(let title, _, _):
            return title
        }
    }
    
    /// A `String` containing the system image to use for the link.
    var systemImage: String {
        switch self {
        case .productPage(_):
            return "house"
        case .repository(_):
            return "hammer"
        case .compliance(_):
            return "checkmark.shield"
        case .custom(_, let systemImage, _):
            return systemImage
        }
    }
    
    /// The `URL` to open when the link is selected.
    var url: URL {
        switch self {
        case .productPage(let url):
            return url
        case .repository(let url):
            return url
        case .compliance(let url):
            return url
        case .custom(_, _, let url):
            return url
        }
    }
}
