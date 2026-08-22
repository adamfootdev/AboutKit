//
//  AboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS) || os(visionOS)
import SwiftUI
import MessageUI

/// A SwiftUI `View` which displays attributes and links relating to an app.
public struct AboutAppView: View {
    @Environment(\.openURL) var openURL

    /// A custom struct of type `AKConfiguration` containing details for AboutKit.
    private let configuration: AKConfiguration

    /// A `Bool` indicating whether the Mail sheet is currently showing.
    @State private var showingMailSheet: Bool = false

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
        .navigationTitle(LocalizedStrings.aboutApp)
        .sheet(isPresented: $showingMailSheet) {
            MailView(app: configuration.app, debugDetails: AboutKit.debugDetails)
                .edgesIgnoringSafeArea(.all)
        }
    }


    // MARK: - Sections

    @ViewBuilder
    private func content(for section: AKSection) -> some View {
        switch section {
        case .header:
            Section {
                HeaderView(app: configuration.app)
            }

        case .contact:
            if configuration.app.email != nil || configuration.app.websiteURL != nil {
                Section {
                    Button(action: sendMail) {
                        ItemLabel(
                            LocalizedStrings.email,
                            systemImage: "envelope"
                        )
                    }

                    if let websiteURL = configuration.app.websiteURL {
                        Button {
                            openURL(websiteURL)
                        } label: {
                            ItemLabel(
                                LocalizedStrings.website,
                                systemImage: "safari"
                            )
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
                        Button {
                            openURL(profile.url)
                        } label: {
                            ItemLabel(
                                profile.title,
                                image: profile.platform.imageName
                            )
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
                        Button {
                            openURL(profile.url)
                        } label: {
                            ItemLabel(
                                profile.title,
                                image: profile.platform.imageName
                            )
                        }
                    }
                }
            }

        case .sharingAndReview:
            if configuration.showShareApp.isVisible || configuration.showWriteReview.isVisible {
                Section {
                    if configuration.showShareApp.isVisible {
                        ShareLink(
                            item: configuration.app.appStoreShareURL,
                            message: Text(String(localized: "Check out \(configuration.app.name) on the App Store!", bundle: .module))
                        ) {
                            ItemLabel(
                                LocalizedStrings.shareApp,
                                systemImage: "square.and.arrow.up"
                            )
                        }
                    }

                    if configuration.showWriteReview.isVisible {
                        Button {
                            openURL(configuration.app.appStoreReviewURL)
                        } label: {
                            ItemLabel(
                                LocalizedStrings.writeReview,
                                systemImage: "star"
                            )
                        }
                    }
                }
            }

        case .legalAndAcknowledgements:
            if configuration.app.privacyPolicyURL != nil || configuration.app.termsOfUseURL != nil || configuration.app.acknowledgements?.frameworks?.isEmpty == false || configuration.app.acknowledgements?.people?.isEmpty == false {
                Section {
                    if let privacyPolicyURL = configuration.app.privacyPolicyURL {
                        Button {
                            openURL(privacyPolicyURL)
                        } label: {
                            ItemLabel(
                                LocalizedStrings.privacyPolicy,
                                systemImage: "lock.shield"
                            )
                        }
                    }

                    if let termsOfUseURL = configuration.app.termsOfUseURL {
                        Button {
                            openURL(termsOfUseURL)
                        } label: {
                            ItemLabel(
                                LocalizedStrings.termsOfUse,
                                systemImage: "checkmark.seal"
                            )
                        }
                    }

                    if let acknowledgements = configuration.app.acknowledgements {
                        if acknowledgements.frameworks?.isEmpty == false || acknowledgements.people?.isEmpty == false {
                            NavigationLink {
                                AcknowledgementsView(acknowledgements)
                            } label: {
                                ItemLabel(
                                    LocalizedStrings.acknowledgements,
                                    systemImage: "list.star"
                                )
                            }
                        }
                    }
                }
            }

        case .testFlight:
            if let testFlightURL = configuration.app.testFlightURL {
                Section {
                    Button {
                        openURL(testFlightURL)
                    } label: {
                        ItemLabel(
                            LocalizedStrings.testFlight,
                            systemImage: "fan"
                        )
                    }
                }
            }

        case .otherApps:
            if configuration.otherApps.isEmpty == false {
                Section {
                    ForEach(configuration.otherApps, content: OtherAppRowView.init)

                    Button {
                        openURL(configuration.app.developer.appStoreURL)
                    } label: {
                        Text(LocalizedStrings.viewAllApps)
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
        if MFMailComposeViewController.canSendMail() {
            showingMailSheet = true
        } else {
            guard let subject = configuration.app.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                  let body = AboutKit.debugDetails.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

            guard let email = configuration.app.email else { return }

            let urlString = "mailto:\(email)?subject=\(subject)%20-%20Support&body=\(body)"

            if let url = URL(string: urlString) {
                openURL(url)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AboutAppView(configuration: .example)
    }
}
#endif
