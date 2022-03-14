//
//  MailView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS)
import SwiftUI
import MessageUI

/// A UIViewControllerRepresentable that shows the default iOS mail sheet
/// with some pre-configured fields based on the current app.
struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    /// The app to use for providing data to show in the mail sheet.
    private let app: AKApp

    /// A string containing some debug information that will be sent to the developer.
    private let debugDetails: String

    /// Initializes a UIViewControllerRepresentable that shows the default iOS mail sheet
    /// with some pre-configured fields based on the current app.
    /// - Parameters:
    ///   - app: The app to use for providing data to show in the mail sheet.
    ///   - debugDetails: A string containing some debug information that will be sent to the developer.
    init(app: AKApp, debugDetails: String) {
        self.app = app
        self.debugDetails = debugDetails
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentationMode: PresentationMode
        
        init(presentationMode: Binding<PresentationMode>) {
            _presentationMode = presentationMode
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            $presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        mailComposerViewController.mailComposeDelegate = context.coordinator
        
        mailComposerViewController.setToRecipients([app.email])
        mailComposerViewController.setSubject("\(app.name) - Support")
        mailComposerViewController.setMessageBody(debugDetails, isHTML: false)
        
        return mailComposerViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
}
#endif
