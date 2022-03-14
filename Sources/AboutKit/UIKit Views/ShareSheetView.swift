//
//  ShareSheetView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS)
import SwiftUI

/// A UIViewControllerRepresentable that shows the default iOS share sheet
/// with some details on how to install the current app.
struct ShareSheetView: UIViewControllerRepresentable {
    /// The app to use for showing in the download message.
    private let app: AKApp

    /// Initializes a UIViewControllerRepresentable that shows the default iOS share sheet
    /// with some details on how to install the current app.
    /// - Parameter app: The app to use for showing in the download message.
    init(app: AKApp) {
        self.app = app
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheetView>) -> UIActivityViewController {
        let appURL = URL(string: "https://apps.apple.com/app/id\(app.id)")!
        let message = String(format: NSLocalizedString("Check out %@ on the App Store!", bundle: .module, comment: ""), app.name)
        
        let activityViewController = UIActivityViewController(activityItems: [appURL, message], applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheetView>) {}
}
#endif
