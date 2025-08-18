//
//  HeaderView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct HeaderView: View {
    private let app: AKMyApp

    init(app: AKMyApp) {
        self.app = app
    }

    var body: some View {
        VStack(spacing: 8) {
            AppIconView(for: app, at: appIconSize)

            Text("\(app.name) \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))")
                .font(.headline)
                .padding(.top)

            Text(app.developer.name)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
    }

    private var appIconSize: CGSize {
        #if os(macOS) || os(watchOS)
        return .init(width: 64, height: 64)
        #elseif os(tvOS)
        return .init(width: 300, height: 180)
        #else
        return .init(width: 100, height: 100)
        #endif
    }
}

#Preview {
    List {
        HeaderView(app: AKMyApp.example)
            .listRowBackground(Color.clear)
    }
}
