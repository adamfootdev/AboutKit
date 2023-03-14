//
//  AKProfileDisplayMode.swift
//  AboutKit
//
//  Created by Adam Foot on 26/01/2023.
//

import Foundation

public enum AKProfileDisplayMode: Hashable {
    case combined
    case platformOnly
    case usernameOnly
    case custom(_ value: String)
}
