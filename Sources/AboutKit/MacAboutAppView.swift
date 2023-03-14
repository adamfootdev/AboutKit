//
//  MacAboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2023.
//

#if os(macOS)
import SwiftUI

struct AboutAppView: View {
    @Environment(\.openURL) var openURL

    /// A custom struct containing details about the current app.
    private let app: AKMyApp

    /// An array of custom structs that contain details about other apps the developer owns.
    private let otherApps: [AKOtherApp]

    /// Initializes a new SwiftUI view which displays attributes and links relating to an app.
    /// - Parameters:
    ///   - app: A custom struct containing details about the current app.
    ///   - otherApps: An array of custom structs that contain details about other apps the developer owns.
    public init(app: AKMyApp, otherApps: [AKOtherApp]) {
        self.app = app
        self.otherApps = otherApps
    }

    public var body: some View {
        Form {
            Section {
                HeaderView(app: app)
                    .padding(.vertical, 8)
            }

            Section {
                ItemLabel(
                    LocalizedStrings.email,
                    actionTitle: LocalizedStrings.contactDeveloper,
                    action: sendMail
                )

                if let websiteURL = URL(string: app.websiteURL) {
                    ItemLabel(
                        LocalizedStrings.website,
                        actionTitle: LocalizedStrings.openWebsite
                    ) {
                        openURL(websiteURL)
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
                            profile.title,
                            actionTitle: LocalizedStrings.viewProfile
                        ) {
                            openURL(profile.url)
                        }
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
                            profile.title,
                            actionTitle: LocalizedStrings.viewProfile
                        ) {
                            openURL(profile.url)
                        }
                    }
                }
            }

            Section {
                HStack {
                    Text(LocalizedStrings.shareApp)
                    Spacer()

                    ShareLink(
                        item: app.appStoreURL,
                        message: Text(String(localized: "Check out \(app.name) on the App Store!", bundle: .module))
                    ) {
                        Text(LocalizedStrings.share)
                    }
                }

                ItemLabel(
                    LocalizedStrings.writeReview,
                    actionTitle: LocalizedStrings.review
                ) {
                    openURL(app.appStoreReviewURL)
                }
            }

            if app.privacyPolicyURL != nil || app.termsOfUseURL != nil {
                Section {
                    if let privacyPolicy = app.privacyPolicyURL,
                       let privacyPolicyURL = URL(string: privacyPolicy) {
                        ItemLabel(
                            LocalizedStrings.privacyPolicy,
                            actionTitle: LocalizedStrings.viewPrivacyPolicy
                        ) {
                            openURL(privacyPolicyURL)
                        }
                    }

                    if let termsOfUse = app.termsOfUseURL,
                       let termsOfUseURL = URL(string: termsOfUse) {
                        ItemLabel(
                            LocalizedStrings.termsOfUse,
                            actionTitle: LocalizedStrings.viewTermsOfUse
                        ) {
                            openURL(termsOfUseURL)
                        }
                    }
                }
            }

            if otherApps.isEmpty == false {
                Section {
                    ForEach(otherApps, content: OtherAppRowView.init)

                    ItemLabel(
                        LocalizedStrings.viewAllApps,
                        actionTitle: LocalizedStrings.viewMac
                    ) {
                        openURL(app.developer.appStoreURL)
                    }

                } header: {
                    Text(LocalizedStrings.otherApps)
                }
            }
        }
        .formStyle(.grouped)
    }

    private func sendMail() {
        guard let subject = app.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let body = Bundle.main.debugDetails.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        let urlString = "mailto:\(app.email)?subject=\(subject)%20-%20Support&body=\(body)"

        if let url = URL(string: urlString) {
            openURL(url)
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView(
            app: AKMyApp.example,
            otherApps: [AKOtherApp.example, AKOtherApp.example]
        )
    }
}
#endif
