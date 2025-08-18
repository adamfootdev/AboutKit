//
//  PlatformImage+Transparency.swift
//  AboutKit
//
//  Created by Adam Foot on 18/08/2025.
//

import SwiftUI

#if os(macOS)
extension NSImage {
    var hasAlpha: Bool {
        guard let alphaInfo = self.cgImage(forProposedRect: nil, context: nil, hints: nil)?.alphaInfo else { return false }
        switch alphaInfo {
        case .none, .noneSkipLast, .noneSkipFirst:
            return false
        default:
            return true
        }
    }
}

#else
extension UIImage {
    var hasAlpha: Bool {
        guard let alphaInfo = self.cgImage?.alphaInfo else { return false }
        switch alphaInfo {
        case .none, .noneSkipLast, .noneSkipFirst:
            return false
        default:
            return true
        }
    }
}
#endif
