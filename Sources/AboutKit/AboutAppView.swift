//
//  AboutAppView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI
import MessageUI

/// A SwiftUI view which displays attributes and links relating to an app.
public struct AboutAppView: View {
    /// A custom struct containing details about the current app.
    private let app: AKApp

    /// An array of custom structs that contain details about other apps the developer owns.
    private let otherApps: [AKOtherApp]
    
    private enum ActiveSheet: Identifiable {
        case mail, share
        var id: Int { hashValue }
    }
    
    @State private var activeSheet: ActiveSheet?

    private var appReviewURL: String {
        "https://apps.apple.com/app/id\(app.id)?action=write-review"
    }

    private var developerURL: String {
        "https://apps.apple.com/developer/id\(app.developer.id)"
    }

    private var debugDetails: String {
        "\n\n\nDEBUG DETAILS\n\nApp Version: \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))\niOS Version: \(UIDevice.current.systemVersion)\nDevice: \(UIDevice.current.deviceType)"
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
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
            }
            
            Section {
                Button(action: sendMail) {
                    Label(LocalizedStrings.email, systemImage: "envelope")
                }
                
                if let appTwitterDetails = getTwitterDetails(for: app.twitterHandle) {
                    Link(destination: appTwitterDetails.url) {
                        Label(appTwitterDetails.title, systemImage: "at")
                    }
                }

                if let developerTwitterDetails = getTwitterDetails(for:  app.developer.twitterHandle) {
                    Link(destination: developerTwitterDetails.url) {
                        Label(developerTwitterDetails.title, systemImage: "at")
                    }
                }

                if let websiteURL = URL(string: app.websiteURL) {
                    Link(destination: websiteURL) {
                        Label(LocalizedStrings.website, systemImage: "safari")
                    }
                }
            }
            
            Section {
                Button(action: showShareSheet) {
                    Label(LocalizedStrings.shareApp, systemImage: "square.and.arrow.up")
                }
                
                Link(destination: URL(string: appReviewURL)!) {
                    Label(LocalizedStrings.writeReview, systemImage: "star.fill")
                }
            }
            
            if let privacyPolicyURLString = app.privacyPolicyURL {
                Section {
                    Link(destination: URL(string: privacyPolicyURLString)!) {
                        Label(LocalizedStrings.privacyPolicy, systemImage: "lock.fill")
                    }
                }
            }

            if otherApps.isEmpty == false {
                Section(header: Text(LocalizedStrings.otherApps)) {
                    ForEach(otherApps, content: OtherAppRowView.init)

                    Link(LocalizedStrings.viewAll, destination: URL(string: developerURL)!)
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

            let urlString = "mailto:info@adamfoot.dev?subject=\(subject)%20-%20Support&body=\(body)"

            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
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
