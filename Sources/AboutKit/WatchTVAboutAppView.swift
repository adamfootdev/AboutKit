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

    /// A custom struct of type `AKConfiguration` containing details for AboutKit.
    private let configuration: AKConfiguration

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
    }


    // MARK: - Sections

    @ViewBuilder
    private func content(for section: AKSection) -> some View {
        switch section {
        case .header:
            Section {
                HeaderView(app: configuration.app)
                    .focusable()
            }

        case .contact:
            if configuration.app.email != nil || configuration.app.websiteURL != nil {
                Section {
                    if let email = configuration.app.email {
                        ItemLabel(
                            LocalizedStrings.email,
                            details: email
                        )
                    }

                    if let websiteURL = configuration.app.websiteURL {
                        ItemLabel(
                            LocalizedStrings.website,
                            details: websiteURL.absoluteString
                        )
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
                            profile.platform.name,
                            details: profile.displayUsername
                        )
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
                            profile.platform.name,
                            details: profile.displayUsername
                        )
                    }
                }
            }

        case .sharingAndReview:
            EmptyView()

        case .legalAndAcknowledgements:
            if configuration.app.privacyPolicyURL != nil || configuration.app.termsOfUseURL != nil || configuration.app.acknowledgements?.frameworks?.isEmpty == false || configuration.app.acknowledgements?.people?.isEmpty == false {
                Section {
                    if let privacyPolicyURL = configuration.app.privacyPolicyURL {
                        ItemLabel(
                            LocalizedStrings.privacyPolicy,
                            details: privacyPolicyURL.absoluteString
                        )
                    }

                    if let termsOfUseURL = configuration.app.termsOfUseURL {
                        ItemLabel(
                            LocalizedStrings.termsOfUse,
                            details: termsOfUseURL.absoluteString
                        )
                    }

                    if let acknowledgements = configuration.app.acknowledgements {
                        if acknowledgements.frameworks?.isEmpty == false || acknowledgements.people?.isEmpty == false {
                            NavigationLink(LocalizedStrings.acknowledgements) {
                                AcknowledgementsView(acknowledgements)
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
                        details: testFlightURL.absoluteString
                    )
                }
            }

        case .otherApps:
            if configuration.otherApps.isEmpty == false {
                Section {
                    ForEach(
                        configuration.otherApps,
                        content: OtherAppRowView.init
                    )

                    Link(
                        LocalizedStrings.viewAllApps,
                        destination: configuration.app.developer.appStoreURL
                    )
                } header: {
                    #if os(tvOS)
                    SectionHeaderLabel(LocalizedStrings.otherApps)
                    #else
                    Text(LocalizedStrings.otherApps)
                    #endif
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
                        #if os(tvOS)
                        SectionHeaderLabel(title)
                        #else
                        Text(title)
                        #endif
                    }
                }
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
