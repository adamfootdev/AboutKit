//
//  AboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 13/05/2022.
//

import SwiftUI

#if os(tvOS)
public struct AboutAppView: View {

    /// A custom struct containing details about the current app.
    private let app: AKApp

    /// A `Bool` indicating whether to show the navigation title or not. Defaults to false.
    private let showNavigationTitle: Bool

    /// Initializes a new SwiftUI view which displays attributes and links relating to an app.
    /// - Parameters:
    ///   - app: A custom struct containing details about the current app.
    ///   - showNavigationTitle: A `Bool` indicating whether to show the navigation title or not. Defaults to false.
    public init(app: AKApp, showNavigationTitle: Bool = false) {
        self.app = app
        self.showNavigationTitle = showNavigationTitle
    }

    public var body: some View {
        Group {
            if showNavigationTitle {
                aboutForm
                    .navigationTitle(LocalizedStrings.about)
            } else {
                aboutForm
            }
        }
    }

    private var aboutForm: some View {
        Form {
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

            if let privacyPolicyURL = app.privacyPolicyURL {
                Section {
                    ItemLabel(LocalizedStrings.privacyPolicy, details: privacyPolicyURL)
                }
            }
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutAppView(app: AKApp.example)
        }
    }
}
#endif
