//
//  OtherAppRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct OtherAppRowView: View {
    let otherApp: AKOtherApp
    @State private var appIconURL: String?

    private var viewLabel: Text {
        Text(String(format: NSLocalizedString("View %@ in the App Store", bundle: .module, comment: ""), otherApp.name))
    }

    private var appURL: String {
        "https://apps.apple.com/app/id\(otherApp.id)"
    }

    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                
                if let appIconURL = appIconURL {
                    RemoteImageView(url: appIconURL)
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            Text(otherApp.name)
                .font(.headline)

            Spacer()

            Link(destination: URL(string: appURL)!) {
                Text(LocalizedStrings.view)
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Color(UIColor.systemGroupedBackground))
                    .clipShape(Capsule())
                    .contentShape(Capsule())
                    .hoverEffect(.lift)
                    .accessibility(label: viewLabel)
            }
        }
        .padding(.vertical, 8)
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text(otherApp.name))
        .onAppear {
            AppIconNetworkManager.shared.getURL(for: otherApp.id) { (appIconURL) in
                DispatchQueue.main.async {
                    self.appIconURL = appIconURL
                }
            }
        }
    }
}

struct OtherAppRowView_Previews: PreviewProvider {
    static var previews: some View {
        OtherAppRowView(otherApp: AKOtherApp.example)
    }
}
