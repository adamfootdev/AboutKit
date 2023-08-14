//
//  WatchTVAboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2022.
//

#if os(watchOS) || os(tvOS)
import SwiftUI

/// A SwiftUI `View` which displays attributes and links relating to an app.
public struct AboutAppView: View {

    /// A custom struct of type `AKMyApp` containing details about the current app.
    private let app: AKMyApp

    /// An array of `AKOtherApp` that contains details about other apps the developer owns.
    private let otherApps: [AKOtherApp]
    
    /// Initializes a new SwiftUI `View` which displays attributes and links relating to an app.
    /// - Parameters:
    ///   - app: A custom struct of type `AKMyApp` containing details about the current app.
    ///   - otherApps: An array of `AKOtherApp` that contains details about other apps the developer owns.
    public init(app: AKMyApp, otherApps: [AKOtherApp]) {
        self.app = app
        self.otherApps = otherApps
    }
    
    public var body: some View {
        Form {
            Section {
                HeaderView(app: app)
                    .focusable()
            }

            if app.email != nil || app.websiteURL != nil {
                Section {
                    if let email = app.email {
                        ItemLabel(
                            LocalizedStrings.email,
                            details: email
                        )
                    }

                    if let websiteURL = app.websiteURL,
                       URL(string: websiteURL) != nil {
                        ItemLabel(LocalizedStrings.website, details: websiteURL)
                    }
                }
            }

            if app.developer.profiles.isEmpty == false {
                Section {
                    ForEach(
                        Array(app.developer.profiles.enumerated()),
                        id: \.0
                    ) { _, profile in
                        ItemLabel(
                            profile.platform.name,
                            details: profile.displayUsername
                        )
                    }
                }
            }

            if app.profiles.isEmpty == false {
                Section {
                    ForEach(
                        Array(app.profiles.enumerated()),
                        id: \.0
                    ) { _, profile in
                        ItemLabel(
                            profile.platform.name,
                            details: profile.displayUsername
                        )
                    }
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

            if app.acknowledgements.isEmpty == false {
                Section {
                    NavigationLink(LocalizedStrings.acknowledgements) {
                        AcknowledgementsView(app.acknowledgements)
                    }
                }
            }

            if otherApps.isEmpty == false {
                Section(header: Text(LocalizedStrings.otherApps)) {
                    ForEach(otherApps, content: OtherAppRowView.init)
                    Link(LocalizedStrings.viewAllApps, destination: app.developer.appStoreURL)
                }
            }
        }
        .navigationTitle(LocalizedStrings.about)
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutAppView(
                app: AKMyApp.example,
                otherApps: [AKOtherApp.example, AKOtherApp.example]
            )
        }
    }
}
#endif
