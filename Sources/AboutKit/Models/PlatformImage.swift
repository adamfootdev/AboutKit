//
//  PlatformImage.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2023.
//

import SwiftUI

#if os(macOS)
public typealias PlatformImage = NSImage
#else
public typealias PlatformImage = UIImage
#endif
