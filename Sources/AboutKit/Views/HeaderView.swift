//
//  HeaderView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct HeaderView: View {
    private let app: AKMyApp

    @State private var appIconURL: String?

    init(app: AKMyApp) {
        self.app = app
    }

    var body: some View {
        VStack(spacing: 8) {
            appIcon

            Text("\(app.name) \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))")
                .font(.headline)
                .padding(.top)

            Text(app.developer.name)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
        .task {
            await loadAppIcon()
        }
    }

    private var appIcon: some View {
        ZStack {
            #if os(iOS)
            Color(.secondarySystemGroupedBackground)
            #elseif os(watchOS) || os(tvOS)
            Color.white.opacity(0.2)
            #endif

            if let appIcon = app.appIcon {
                #if os(macOS)
                Image(nsImage: appIcon)
                    .resizable()
                    .scaledToFit()
                #else
                Image(uiImage: appIcon)
                    .resizable()
                    .scaledToFit()
                #endif

            } else if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
            }
        }
        .frame(width: appIconWidth, height: appIconHeight)
        #if os(iOS) || os(tvOS)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        #elseif os(macOS)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        #elseif os(watchOS)
        .clipShape(Circle())
        #endif
        .accessibilityHidden(true)
    }

    private var appIconWidth: CGFloat {
        #if os(macOS) || os(watchOS)
        return 64
        #elseif os(tvOS)
        return 300
        #else
        return 100
        #endif
    }

    private var appIconHeight: CGFloat {
        #if os(macOS) || os(watchOS)
        return 64
        #elseif os(tvOS)
        return 180
        #else
        return 100
        #endif
    }

    private func loadAppIcon() async {
        if app.appIcon == nil {
            appIconURL = await AppIconNetworkManager.shared.fetchURL(for: app)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HeaderView(app: AKMyApp.example)
                .listRowBackground(Color.clear)
        }
    }
}
