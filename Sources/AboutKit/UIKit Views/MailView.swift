//
//  MailView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS) || os(visionOS)
import SwiftUI
import MessageUI

/// A `UIViewControllerRepresentable` that shows the default iOS mail sheet
/// with some pre-configured fields based on the current app.
struct MailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss

    /// The `AKMyApp` to use for providing data to show in the Mail sheet.
    private let app: AKMyApp

    /// A `String` containing some debug information that will be sent to the developer.
    private let debugDetails: String

    /// Initializes a `UIViewControllerRepresentable` that shows the default iOS mail sheet
    /// with some pre-configured fields based on the current app.
    /// - Parameters:
    ///   - app: The `AKMyApp` to use for providing data to show in the Mail sheet.
    ///   - debugDetails: A `String` containing some debug information that will be sent to the developer.
    init(app: AKMyApp, debugDetails: String) {
        self.app = app
        self.debugDetails = debugDetails
    }
    
    class Coordinator: NSObject, @preconcurrency MFMailComposeViewControllerDelegate {
        private var dismiss: DismissAction
        
        init(dismiss: DismissAction) {
            self.dismiss = dismiss
        }
        
        @MainActor
        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dismiss: dismiss)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        mailComposerViewController.mailComposeDelegate = context.coordinator

        if let email = app.email {
            mailComposerViewController.setToRecipients([email])
        }

        mailComposerViewController.setSubject("\(app.name) - Support")
        mailComposerViewController.setMessageBody(debugDetails, isHTML: false)
        
        return mailComposerViewController
    }
    
    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<MailView>
    ) {}
}
#endif
