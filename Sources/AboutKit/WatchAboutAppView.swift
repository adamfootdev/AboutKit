//
//  WatchAboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2022.
//

#if os(watchOS)
import SwiftUI

/// A SwiftUI view which displays attributes and links relating to an app.
public struct AboutAppView: View {
    
    /// A custom struct containing details about the current app.
    private let app: AKApp
    
    /// Initializes a new SwiftUI view which displays attributes and links relating to an app.
    /// - Parameters:
    ///   - app: A custom struct containing details about the current app.
    public init(app: AKApp) {
        self.app = app
    }
    
    public var body: some View {
        List {
            Section {
                HeaderView(app: app)
            }
            
            Section {
                ItemLabel(
                    LocalizedStrings.email,
                    details: app.email
                )
                
                if let appTwitterHandle = app.twitterHandle {
                    ItemLabel("Twitter", details: "@\(appTwitterHandle)")
                }

                if let developerTwitterHandle = app.developer.twitterHandle {
                    ItemLabel("Twitter", details: "@\(developerTwitterHandle)")
                }
                
                if let websiteURL = app.websiteURL {
                    ItemLabel(LocalizedStrings.website, details: websiteURL)
                }
            }
            
            if app.privacyPolicyURL != nil || app.termsOfUseURL != nil {
                Section {
                    if let privacyPolicyURL = app.privacyPolicyURL {
                        ItemLabel(LocalizedStrings.privacyPolicy, details: privacyPolicyURL)
                    }

                    if let termsOfUseURL = app.termsOfUseURL {
                        ItemLabel(LocalizedStrings.termsOfUse, details: termsOfUseURL)
                    }
                }
            }
        }
        .navigationTitle(LocalizedStrings.about)
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView(app: AKApp.example)
    }
}
#endif
