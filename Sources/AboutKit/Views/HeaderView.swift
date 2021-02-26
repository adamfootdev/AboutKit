//
//  HeaderView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

struct HeaderView: View {
    let app: AKApp

    @State private var appIconURL: String?

    var appIconLabel: Text {
        Text(String(format: NSLocalizedString("%@ App Icon", bundle: .module, comment: ""), app.name))
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.systemGroupedBackground
                
                if let appIcon = app.appIcon {
                    Image(uiImage: appIcon)
                        .resizable()
                        .scaledToFit()
                    
                } else if let appIconURL = appIconURL {
                    RemoteImageView(url: appIconURL)
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .accessibility(label: appIconLabel)

            Text("\(app.name) \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top)

            Text(app.developer.name)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            if app.appIcon == nil {
                AppIconNetworkManager.shared.getURL(for: app.id) { (appIconURL) in
                    DispatchQueue.main.async {
                        self.appIconURL = appIconURL
                    }
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(app: AKApp.example)
    }
}
