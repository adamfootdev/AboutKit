//
//  MacAboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2023.
//

#if os(macOS)
import SwiftUI

/// A SwiftUI `View` which displays attributes and links relating to an app.
public struct AboutAppView: View {
    @Environment(\.openURL) var openURL

    /// A custom struct of type `AKConfiguration` containing details for AboutKit.
    private let configuration: AKConfiguration

    /// A `Boolean` indicating whether the Acknowledgements view is visible.
    @State private var showingAcknowledgements: Bool = false

    /// Initializes a new SwiftUI `View` which displays attributes and links relating to an app.
    /// - Parameter configuration: A custom struct of type `AKConfiguration` containing details for AboutKit.
    public init(configuration: AKConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        Form {
            Section {
                HeaderView(app: configuration.app)
                    .padding(.vertical, 8)
            }

            if configuration.app.email != nil || configuration.app.websiteURL != nil {
                Section {
                    ItemLabel(
                        LocalizedStrings.email,
                        actionTitle: LocalizedStrings.contactDeveloper,
                        action: sendMail
                    )
                    
                    if let websiteURL = configuration.app.websiteURL {
                        ItemLabel(
                            LocalizedStrings.website,
                            actionTitle: LocalizedStrings.openWebsite
                        ) {
                            openURL(websiteURL)
                        }
                    }
                }
            }

            if configuration.app.developer.profiles.isEmpty == false {
                Section {
                    ForEach(
                        Array(configuration.app.developer.profiles.enumerated()),
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

            if configuration.app.profiles.isEmpty == false {
                Section {
                    ForEach(
                        Array(configuration.app.profiles.enumerated()),
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

            if configuration.showShareApp.isVisible || configuration.showWriteReview.isVisible {
                Section {
                    if configuration.showShareApp.isVisible {
                        HStack {
                            Text(LocalizedStrings.shareApp)
                            Spacer()

                            ShareLink(
                                item: configuration.app.appStoreShareURL,
                                message: Text(String(localized: "Check out \(configuration.app.name) on the App Store!", bundle: .module))
                            ) {
                                Text(LocalizedStrings.share)
                            }
                        }
                    }

                    if configuration.showWriteReview.isVisible {
                        ItemLabel(
                            LocalizedStrings.writeReview,
                            actionTitle: LocalizedStrings.review
                        ) {
                            openURL(configuration.app.appStoreReviewURL)
                        }
                    }
                }
            }

            if configuration.app.privacyPolicyURL != nil || configuration.app.termsOfUseURL != nil || configuration.app.acknowledgements?.frameworks?.isEmpty == false || configuration.app.acknowledgements?.people?.isEmpty == false {
                Section {
                    if let privacyPolicyURL = configuration.app.privacyPolicyURL {
                        ItemLabel(
                            LocalizedStrings.privacyPolicy,
                            actionTitle: LocalizedStrings.viewPrivacyPolicy
                        ) {
                            openURL(privacyPolicyURL)
                        }
                    }

                    if let termsOfUseURL = configuration.app.termsOfUseURL {
                        ItemLabel(
                            LocalizedStrings.termsOfUse,
                            actionTitle: LocalizedStrings.viewTermsOfUse
                        ) {
                            openURL(termsOfUseURL)
                        }
                    }

                    if let acknowledgements = configuration.app.acknowledgements {
                        if acknowledgements.frameworks?.isEmpty == false || acknowledgements.people?.isEmpty == false {
                            ItemLabel(
                                LocalizedStrings.acknowledgements,
                                actionTitle: LocalizedStrings.viewAcknowledgements
                            ) {
                                showingAcknowledgements.toggle()
                            }
                        }
                    }
                }
            }

            if let testFlightURL = configuration.app.testFlightURL {
                Section {
                    ItemLabel(
                        LocalizedStrings.testFlight,
                        actionTitle: LocalizedStrings.openTestFlight
                    ) {
                        openURL(testFlightURL)
                    }
                }
            }

            if configuration.otherApps.isEmpty == false {
                Section {
                    ForEach(configuration.otherApps, content: OtherAppRowView.init)

                    ItemLabel(
                        LocalizedStrings.viewAllApps,
                        actionTitle: LocalizedStrings.viewMac
                    ) {
                        openURL(configuration.app.developer.appStoreURL)
                    }

                } header: {
                    Text(LocalizedStrings.otherApps)
                }
            }
        }
        .formStyle(.grouped)
        .navigationTitle(LocalizedStrings.aboutApp)
        .sheet(isPresented: $showingAcknowledgements) {
            if let acknowledgements = configuration.app.acknowledgements {
                AcknowledgementsView(acknowledgements)
            }
        }
    }

    
    // MARK: - Mail

    private func sendMail() {
        guard let subject = configuration.app.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let body = AboutKit.debugDetails.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        guard let email = configuration.app.email else { return }

        let urlString = "mailto:\(email)?subject=\(subject)%20-%20Support&body=\(body)"

        if let url = URL(string: urlString) {
            openURL(url)
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView(configuration: .example)
    }
}
#endif
