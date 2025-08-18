//
//  AppIconImageView.swift
//  AboutKit
//
//  Created by Adam Foot on 18/08/2025.
//

import SwiftUI

struct AppIconImageView: View {
    private let app: any AKApp
    private let size: CGSize
    @State private var appIcon: PlatformImage?

    init(for app: any AKApp, at size: CGSize) {
        self.app = app
        self.size = size
        _appIcon = State(wrappedValue: app.appIcon)
    }

    var body: some View {
        ZStack {
            if let displayedAppIconImage,
               appIcon?.hasAlpha == true {
                displayedAppIconImage
                    .scaledToFit()

            } else {
                Group {
                    Color.secondary.opacity(0.2)

                    if let displayedAppIconImage {
                        displayedAppIconImage
                            .scaledToFit()
                    }
                }
                #if os(iOS) || os(tvOS)
                .clipShape(RoundedRectangle(cornerRadius: appIconRadius, style: .continuous))
                #elseif os(macOS)
                .clipShape(RoundedRectangle(cornerRadius: appIconRadius, style: .continuous))
                #elseif os(visionOS) || os(watchOS)
                .clipShape(Circle())
                #endif
            }
        }
        .frame(width: size.width, height: size.height)
        .accessibilityHidden(true)
        .task(loadAppIcon)
    }

    private func loadAppIcon() async {
        guard appIcon == nil else { return }

        guard let appIconURL = await AppIconNetworkManager.shared.fetchURL(for: app),
              let url = URL(string: appIconURL) else {
            return
        }

        let cacheKey = NSString(string: appIconURL)

        if let cachedImage = AppIconNetworkManager.shared.iconCache.object(forKey: cacheKey) {
            self.appIcon = cachedImage
        } else {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                guard let image = PlatformImage(data: data) else {
                    return
                }

                AppIconNetworkManager.shared.iconCache.setObject(image, forKey: cacheKey)
                self.appIcon = image

            } catch {}
        }
    }

    private var displayedAppIconImage: Image? {
        if let appIcon {
            #if os(macOS)
            return Image(nsImage: appIcon).resizable()
            #else
            return Image(uiImage: appIcon).resizable()
            #endif
        } else {
            return nil
        }
    }

    private var appIconRadius: CGFloat {
        #if os(iOS) || os(macOS)
        return size.height / 5
        #elseif os(tvOS)
        return size.height / 9
        #elseif os(visionOS) || os(watchOS)
        return size.height / 2
        #else
        return size.height / 5
        #endif
    }
}

#Preview {
    List {
        AppIconImageView(for: AKMyApp.example, at: .init(width: 64, height: 64))
            .listRowBackground(Color.clear)
    }
}
