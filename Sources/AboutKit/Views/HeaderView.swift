//
//  HeaderView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct HeaderView: View {
    let app: AKMyApp

    @State private var appIconURL: String?

    var body: some View {
        VStack(spacing: 8) {
            appIcon

            Text("\(app.name) \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))")
                .font(.headline)
                .padding(.top)

            Text(app.developer.name)
                .foregroundColor(.secondary)
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
                Image(uiImage: appIcon)
                    .resizable()
                    .scaledToFit()

            } else if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
            }
        }
        .frame(width: appIconWidth, height: appIconHeight)
        #if os(iOS) || os(tvOS)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        #elseif os(watchOS)
        .clipShape(Circle())
        #endif
        .accessibilityHidden(true)
    }

    private var appIconWidth: CGFloat {
        #if os(iOS)
        return 100
        #elseif os(watchOS)
        return 64
        #elseif os(tvOS)
        return 300
        #endif
    }

    private var appIconHeight: CGFloat {
        #if os(iOS)
        return 100
        #elseif os(watchOS)
        return 64
        #elseif os(tvOS)
        return 180
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
