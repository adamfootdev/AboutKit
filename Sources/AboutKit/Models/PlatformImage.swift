//
//  PlatformImage.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2023.
//

import SwiftUI

#if os(macOS)
extension NSImage: @retroactive @unchecked Sendable {}
public typealias PlatformImage = NSImage
#else
public typealias PlatformImage = UIImage
#endif
