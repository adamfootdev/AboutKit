//
//  OtherAppRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS)
import SwiftUI

struct OtherAppRowView: View {
    let otherApp: AKOtherApp
    @State private var appIconURL: String?

    private var appIcon: some View {
        ZStack {
            Color.systemGroupedBackground

            if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(appIconLabel)
    }

    private var appIconLabel: String {
        String(format: NSLocalizedString(
            "%@ App Icon",
            bundle: .module,
            comment: ""
        ), otherApp.name)
    }

    private var viewLabel: String {
        String(format: NSLocalizedString(
            "View %@ in the App Store",
            bundle: .module,
            comment: ""
        ), otherApp.name)
    }

    private var appURL: String {
        "https://apps.apple.com/app/id\(otherApp.id)"
    }

    private var viewOnAppStoreButton: some View {
        Link(destination: URL(string: appURL)!) {
            Text(LocalizedStrings.view)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.accentColor)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Color.systemGroupedBackground)
                .clipShape(Capsule())
                .contentShape(Capsule())
                #if os(iOS)
                .if(.isCatalyst == false) { $0.hoverEffect(.lift) }
                #endif
                .layoutPriority(1)
                .accessibilityLabel(viewLabel)
        }
    }

    var body: some View {
        HStack(spacing: 15) {
            appIcon

            Text(otherApp.name)
                .font(.headline)
                .lineLimit(2)

            Spacer(minLength: 1)

            viewOnAppStoreButton
        }
        .padding(.vertical, 8)
        .buttonStyle(PlainButtonStyle())
        .onAppear(perform: loadAppIcon)
    }

    private func loadAppIcon() {
        AppIconNetworkManager.shared.getURL(for: otherApp.id) { (appIconURL) in
            DispatchQueue.main.async {
                self.appIconURL = appIconURL
            }
        }
    }
}

struct OtherAppRowView_Previews: PreviewProvider {
    static var previews: some View {
        OtherAppRowView(otherApp: AKOtherApp.example)
    }
}
#endif
