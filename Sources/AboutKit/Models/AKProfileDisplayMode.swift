//
//  AKProfileDisplayMode.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

/// A custom enum that is used to determine how much data to show for a social platform.
public enum AKProfileDisplayMode: Hashable, Sendable {
    case combined
    case platformOnly
    case usernameOnly
    case custom(_ value: String)
}
