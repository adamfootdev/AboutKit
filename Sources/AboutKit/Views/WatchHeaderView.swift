//
//  WatchHeaderView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2022.
//

#if os(watchOS)
import SwiftUI

struct HeaderView: View {
    let app: AKApp
    
    @State private var appIconURL: String?
    
    var body: some View {
        VStack(spacing: 8) {
            appIcon
            
            Text("\(app.name) \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text(app.developer.name)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
        .onAppear(perform: loadAppIcon)
    }
    
    private var appIcon: some View {
        ZStack {
            Color.white.opacity(0.2)
            
            if let appIcon = app.appIcon {
                Image(uiImage: appIcon)
                    .resizable()
                    .scaledToFit()
                
            } else if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
            }
        }
        .frame(width: 64, height: 64)
        .clipShape(Circle())
        .accessibilityLabel(appIconLabel)
    }
    
    private var appIconLabel: String {
        String(format: NSLocalizedString("%@ App Icon", bundle: .module, comment: ""), app.name)
    }
    
    private func loadAppIcon() {
        if app.appIcon == nil {
            AppIconNetworkManager.shared.getURL(for: app.id) { (appIconURL) in
                DispatchQueue.main.async {
                    self.appIconURL = appIconURL
                }
            }
        }
    }
}

struct WatchHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HeaderView(app: .example)
        }
    }
}
#endif
