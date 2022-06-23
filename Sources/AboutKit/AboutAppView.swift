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
    private let app: AKApp

    /// An array of custom structs that contain details about other apps the developer owns.
    private let otherApps: [AKOtherApp]

    /// An enum containing active UIKit sheets.
    private enum ActiveSheet: Identifiable {
        case mail, share
        var id: Int { hashValue }
    }

    /// The current active UIKit sheet.
    @State private var activeSheet: ActiveSheet?

    /// A string containing debug details about the current app.
    private var debugDetails: String {
        "\n\n\nDEBUG DETAILS\n\nApp Version: \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))\niOS Version: \(UIDevice.current.systemVersion)\nDevice: \(UIDevice.current.deviceType)\nEnvironment: \(Bundle.main.userType.name)"
    }

    /// Initializes a new SwiftUI view which displays attributes and links relating to an app.
    /// - Parameters:
    ///   - app: A custom struct containing details about the current app.
    ///   - otherApps: An array of custom structs that contain details about other apps the developer owns.
    public init(app: AKApp, otherApps: [AKOtherApp]) {
        self.app = app
        self.otherApps = otherApps
    }
    
    public var body: some View {
        List {
            Section {
                HeaderView(app: app)
                    .listRowBackground(Color.systemGroupedBackground)
            }
            
            Section {
                Button(action: sendMail) {
                    ListButtonLabel(LocalizedStrings.email, systemImage: "envelope")
                }
                
                if let appTwitterDetails = getTwitterDetails(for: app.twitterHandle) {
                    Link(destination: appTwitterDetails.url) {
                        ListButtonLabel(appTwitterDetails.title, systemImage: "at")
                    }
                }

                if let developerTwitterDetails = getTwitterDetails(for:  app.developer.twitterHandle) {
                    Link(destination: developerTwitterDetails.url) {
                        ListButtonLabel(developerTwitterDetails.title, systemImage: "at")
                    }
                }

                if let websiteURL = URL(string: app.websiteURL) {
                    Link(destination: websiteURL) {
                        ListButtonLabel(LocalizedStrings.website, systemImage: "safari")
                    }
                }
            }
            
            Section {
//                if #available(iOS 16.0, *) {
//                    ShareLink(
//                        item: app.appStoreURL,
//                        message: Text(String(format: NSLocalizedString("Check out %@ on the App Store!", bundle: .module, comment: ""), app.name))
//                    ) {
//                        ListButtonLabel(LocalizedStrings.shareApp, systemImage: "square.and.arrow.up")
//                    }
//                } else {
                    Button(action: showShareSheet) {
                        ListButtonLabel(LocalizedStrings.shareApp, systemImage: "square.and.arrow.up")
                    }
//                }
                
                Link(destination: app.appStoreReviewURL) {
                    ListButtonLabel(LocalizedStrings.writeReview, systemImage: "star")
                }
            }

            if app.privacyPolicyURL != nil || app.termsOfUseURL != nil {
                Section {
                    if let privacyPolicy = app.privacyPolicyURL,
                       let privacyPolicyURL = URL(string: privacyPolicy) {
                        Link(destination: privacyPolicyURL) {
                            ListButtonLabel(LocalizedStrings.privacyPolicy, systemImage: "lock.shield")
                        }
                    }

                    if let termsOfUse = app.termsOfUseURL,
                       let termsOfUseURL = URL(string: termsOfUse) {
                        Link(destination: termsOfUseURL) {
                            ListButtonLabel(LocalizedStrings.termsOfUse, systemImage: "checkmark.seal")
                        }
                    }
                }
            }

            if otherApps.isEmpty == false {
                Section(header: Text(LocalizedStrings.otherApps)) {
                    ForEach(otherApps, content: OtherAppRowView.init)

                    Link(LocalizedStrings.viewAll, destination: app.developer.appStoreURL)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(item: $activeSheet) { (item) in
            switch item {
            case .mail:
                MailView(app: app, debugDetails: debugDetails)
                    .edgesIgnoringSafeArea(.all)
                
            case .share:
                ShareSheetView(app: app)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            activeSheet = .mail
        } else {
            guard let subject = app.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                  let body = debugDetails.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

            let urlString = "mailto:\(app.email)?subject=\(subject)%20-%20Support&body=\(body)"

            if let url = URL(string: urlString) {
                openURL(url)
            }
        }
    }

    private func getTwitterDetails(for handle: String?) -> (title: String, url: URL)? {
        if let handle = handle,
           let url = URL(string: "https://twitter.com/\(handle)") {
            let title = String(format: NSLocalizedString(
                "Twitter (@%@)",
                bundle: .module,
                comment: ""
            ), handle)

            return (title, url)
        }

        return nil
    }
    
    private func showShareSheet() {
        activeSheet = .share
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView(
            app: AKApp.example,
            otherApps: [AKOtherApp.example, AKOtherApp.example]
        )
    }
}
#endif
