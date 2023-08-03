//
//  RemoteImageLoadState.swift
//  AboutKit
//
//  Created by Adam Foot on 03/08/2023.
//

import Foundation

enum RemoteImageLoadState {
    case loading
    case error
    case loaded(image: PlatformImage)
    }
