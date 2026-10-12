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
            ForEach(Array(configuration.sections.enumerated()), id: \.offset) { _, section in
                content(for: section)
            }
        }
        .formStyle(.grouped)
        .navigationTitle(LocalizedStrings.aboutApp(configuration.app.name))
        .sheet(isPresented: $showingAcknowledgements) {
            if let acknowledgements = configuration.app.acknowledgements {
                AcknowledgementsView(acknowledgements)
            }
        }
    }


    // MARK: - Sections

    @ViewBuilder
    private func content(for section: AKSection) -> some View {
        switch section {
        case .header:
            Section {
                HeaderView(app: configuration.app)
                    .padding(.vertical, 8)
            }

        case .contact:
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

        case .developerProfiles:
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

        case .appProfiles:
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

        case .sharingAndReview:
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

        case .legalAndAcknowledgements:
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

        case .testFlight:
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

        case .otherApps:
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

        case .custom(let title, let entries):
            if entries.isEmpty == false {
                Section {
                    ForEach(Array(entries.enumerated()), id: \.offset) { _, entry in
                        entry
                    }
                } header: {
                    if let title {
                        Text(title)
                    }
                }
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

#Preview {
    AboutAppView(configuration: .example)
}
#endif
