//
//  AboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS)
import SwiftUI
import MessageUI

/// A SwiftUI view which displays attributes and links relating to an app.
public struct AboutAppView: View {
    @Environment(\.openURL) var openURL

    /// A custom struct containing details about the current app.
    private let app: AKMyApp

    /// An array of custom structs that contain details about other apps the developer owns.
    private let otherApps: [AKOtherApp]

    /// A Boolean indicating whether the Mail sheet is currently showing.
    @State private var showingMailSheet: Bool = false

    /// A Boolean indicating whether the Share sheet is currently showing.
    @State private var showingShareSheet: Bool = false

    /// Initializes a new SwiftUI view which displays attributes and links relating to an app.
    /// - Parameters:
    ///   - app: A custom struct containing details about the current app.
    ///   - otherApps: An array of custom structs that contain details about other apps the developer owns.
    public init(app: AKMyApp, otherApps: [AKOtherApp]) {
        self.app = app
        self.otherApps = otherApps
    }
    
    public var body: some View {
        List {
            Section {
                HeaderView(app: app)
            }
            
            Section {
                Button(action: sendMail) {
                    ItemLabel(LocalizedStrings.email, systemImage: "envelope")
                }

                if let websiteURL = URL(string: app.websiteURL) {
                    Link(destination: websiteURL) {
                        ItemLabel(
                            LocalizedStrings.website,
                            systemImage: "safari"
                        )
                    }
                }
            }

            if app.developer.profiles.isEmpty == false {
                Section {
                    ForEach(
                        Array(app.developer.profiles.enumerated()),
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

            if app.profiles.isEmpty == false {
                Section {
                    ForEach(
                        Array(app.profiles.enumerated()),
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
            
            Section {
                if #available(iOS 16.0, *) {
                    ShareLink(
                        item: app.appStoreURL,
                        message: Text(String(localized: "Check out \(app.name) on the App Store!", bundle: .module))
                    ) {
                        ItemLabel(
                            LocalizedStrings.shareApp,
                            systemImage: "square.and.arrow.up"
                        )
                    }
                } else {
                    Button {
                        showingShareSheet = true
                    } label: {
                        ItemLabel(
                            LocalizedStrings.shareApp,
                            systemImage: "square.and.arrow.up"
                        )
                    }
                }
                
                Link(destination: app.appStoreReviewURL) {
                    ItemLabel(
                        LocalizedStrings.writeReview,
                        systemImage: "star"
                    )
                }
            }

            if app.privacyPolicyURL != nil || app.termsOfUseURL != nil {
                Section {
                    if let privacyPolicy = app.privacyPolicyURL,
                       let privacyPolicyURL = URL(string: privacyPolicy) {
                        Link(destination: privacyPolicyURL) {
                            ItemLabel(
                                LocalizedStrings.privacyPolicy,
                                systemImage: "lock.shield"
                            )
                        }
                    }

                    if let termsOfUse = app.termsOfUseURL,
                       let termsOfUseURL = URL(string: termsOfUse) {
                        Link(destination: termsOfUseURL) {
                            ItemLabel(
                                LocalizedStrings.termsOfUse,
                                systemImage: "checkmark.seal"
                            )
                        }
                    }
                }
            }

            if otherApps.isEmpty == false {
                Section {
                    ForEach(otherApps, content: OtherAppRowView.init)

                    Link(
                        LocalizedStrings.viewAllApps,
                        destination: app.developer.appStoreURL
                    )
                } header: {
                    Text(LocalizedStrings.otherApps)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(LocalizedStrings.about)
        .sheet(isPresented: $showingMailSheet) {
            MailView(app: app, debugDetails: Bundle.main.debugDetails)
                .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheetView(app: app)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            showingMailSheet = true
        } else {
            guard let subject = app.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                  let body = Bundle.main.debugDetails.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

            let urlString = "mailto:\(app.email)?subject=\(subject)%20-%20Support&body=\(body)"

            if let url = URL(string: urlString) {
                openURL(url)
            }
        }
    }
    
    private func showShareSheet() {
        showingShareSheet = true
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
