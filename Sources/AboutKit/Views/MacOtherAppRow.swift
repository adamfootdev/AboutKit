//
//  MacOtherAppRow.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2023.
//

#if os(macOS)
import SwiftUI

struct OtherAppRowView: View {
    @Environment(\.openURL) private var openURL

    private let otherApp: AKOtherApp

    @State private var appIconURL: String?

    init(_ otherApp: AKOtherApp) {
        self.otherApp = otherApp
    }

    var body: some View {
        HStack(spacing: 12) {
            appIcon

            Text(otherApp.name)
                .font(.headline)
                .lineLimit(2)

            Spacer(minLength: 1)

            viewOnAppStoreButton
        }
        .task {
            await loadAppIcon()
        }
    }

    private var appIcon: some View {
        Group {
            if let appIcon = otherApp.appIcon {
                Image(nsImage: appIcon)
                    .resizable()
                    .scaledToFit()

            } else if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
                    .scaledToFit()
            }
        }
        .frame(width: 32, height: 32)
        .accessibilityHidden(true)
    }

    private var viewOnAppStoreButton: some View {
        Button(LocalizedStrings.viewMac) {
            openURL(otherApp.appStoreURL)
        }
        .accessibilityLabel(String(localized: "View \(otherApp.name) in the App Store", bundle: .module))
    }

    private func loadAppIcon() async {
        if otherApp.appIcon == nil {
            appIconURL = await AppIconNetworkManager.shared.fetchURL(for: otherApp)
        }
    }
}

struct OtherAppRowView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            OtherAppRowView(AKOtherApp.example)
        }
        .formStyle(.grouped)
    }
}
#endif
