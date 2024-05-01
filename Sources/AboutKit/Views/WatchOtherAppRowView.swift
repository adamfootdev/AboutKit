//
//  WatchOtherAppRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 19/07/2022.
//

#if os(watchOS)
import SwiftUI

@MainActor
struct OtherAppRowView: View {
    private let otherApp: AKOtherApp

    @State private var appIconURL: String?

    init(_ otherApp: AKOtherApp) {
        self.otherApp = otherApp
    }

    var body: some View {
        Link(destination: otherApp.appStoreURL) {
            HStack(spacing: 12) {
                appIcon

                Text(otherApp.name)
                    .lineLimit(2)
            }
            .padding(.vertical, 8)

        }
        .buttonStyle(.plain)
        .task {
            await loadAppIcon()
        }
    }

    private var appIcon: some View {
        ZStack {
            Color.secondary.opacity(0.2)

            if let appIcon = otherApp.appIcon {
                Image(uiImage: appIcon)
                    .resizable()
                    .scaledToFit()

            } else if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
                    .scaledToFit()
            }
        }
        .frame(width: 32, height: 32)
        .clipShape(Circle())
        .accessibilityHidden(true)
    }

    private func loadAppIcon() async {
        if otherApp.appIcon == nil {
            appIconURL = await AppIconNetworkManager.shared.fetchURL(
                for: otherApp
            )
        }
    }
}

struct OtherAppRowView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            OtherAppRowView(.example)
        }
    }
}
#endif
