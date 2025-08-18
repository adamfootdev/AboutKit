//
//  TVOtherAppRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 19/07/2022.
//

#if os(tvOS)
import SwiftUI

struct OtherAppRowView: View {
    private let otherApp: AKOtherApp

    init(_ otherApp: AKOtherApp) {
        self.otherApp = otherApp
    }

    var body: some View {
        Link(destination: otherApp.appStoreURL) {
            HStack(spacing: 28) {
                AppIconView(for: otherApp, at: .init(width: 150, height: 90))

                ItemLabel(
                    otherApp.name,
                    details: LocalizedStrings.view
                )
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
