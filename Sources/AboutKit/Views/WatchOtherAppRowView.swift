//
//  WatchOtherAppRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 19/07/2022.
//

#if os(watchOS)
import SwiftUI

struct OtherAppRowView: View {
    private let otherApp: AKOtherApp

    init(_ otherApp: AKOtherApp) {
        self.otherApp = otherApp
    }

    var body: some View {
        Link(destination: otherApp.appStoreURL) {
            HStack(spacing: 12) {
                AppIconImageView(for: otherApp, at: .init(width: 32, height: 32))

                Text(otherApp.name)
                    .lineLimit(2)
            }
            .padding(.vertical, 8)

        }
        .buttonStyle(.plain)
    }
}

#Preview {
    Form {
        OtherAppRowView(.example)
    }
}
#endif
