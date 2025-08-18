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
            AppIconView(for: otherApp, at: .init(width: 32, height: 32))

            Text(otherApp.name)
                .font(.headline)
                .lineLimit(2)

            Spacer(minLength: 1)

            viewOnAppStoreButton
        }
    }

    private var viewOnAppStoreButton: some View {
        Button(LocalizedStrings.viewMac) {
            openURL(otherApp.appStoreURL)
        }
        .accessibilityLabel(String(localized: "View \(otherApp.name) in the App Store", bundle: .module))
    }
}

#Preview {
    Form {
        OtherAppRowView(AKOtherApp.example)
    }
    .formStyle(.grouped)
}
#endif
