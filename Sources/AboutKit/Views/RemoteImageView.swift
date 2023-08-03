//
//  RemoteImageView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct RemoteImageView: View {
    @StateObject private var imageLoader: RemoteImageLoader

    init(url: String) {
        _imageLoader = StateObject(
            wrappedValue: RemoteImageLoader(url: url)
        )
    }
    
    var body: some View {
        downloadedImage.resizable()
    }

    private var downloadedImage: Image {
        switch imageLoader.loadState {
        case .loading, .error:
            #if os(macOS)
            return Image(nsImage: NSImage())
            #else
            return Image(uiImage: UIImage())
            #endif
        case .loaded(let image):
            #if os(macOS)
            return Image(nsImage: image)
            #else
            return Image(uiImage: image)
            #endif
        }
    }
}
