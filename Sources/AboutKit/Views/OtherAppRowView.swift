//
//  OtherAppRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS)
import SwiftUI

struct OtherAppRowView: View {
    private let otherApp: AKOtherApp

    @State private var appIconURL: String?

    init(_ otherApp: AKOtherApp) {
        self.otherApp = otherApp
    }

    var body: some View {
        HStack(spacing: 16) {
            appIcon

            Text(otherApp.name)
                .font(.headline)
                .lineLimit(2)

            Spacer(minLength: 1)

            viewOnAppStoreButton
        }
        .padding(.vertical, 8)
        .buttonStyle(.plain)
        .task {
            await loadAppIcon()
        }
    }

    private var appIcon: some View {
        ZStack {
            Color(.systemGroupedBackground)

            if let appIcon = otherApp.appIcon {
                Image(uiImage: appIcon)
                    .resizable()
                    .scaledToFit()

            } else if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
                    .scaledToFit()
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityHidden(true)
    }

    private var viewOnAppStoreButton: some View {
        Link(destination: otherApp.appStoreURL) {
            Text(LocalizedStrings.view)
                .font(.headline)
                .lineLimit(1)
                .padding(.horizontal, 8)
                #if os(iOS) && !targetEnvironment(macCatalyst)
                .hoverEffect(.lift)
                #endif
                .accessibilityLabel(String(localized: "View \(otherApp.name) in the App Store", bundle: .module))
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.small)
    }

    private func loadAppIcon() async {
        if otherApp.appIcon == nil {
            appIconURL = await AppIconNetworkManager.shared.fetchURL(for: otherApp)
        }
    }
}

struct OtherAppRowView_Previews: PreviewProvider {
    static var previews: some View {
        OtherAppRowView(AKOtherApp.example)
    }
}
#endif
