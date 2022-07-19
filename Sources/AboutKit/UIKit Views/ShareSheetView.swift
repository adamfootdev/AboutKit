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
    private let app: AKMyApp

    /// Initializes a UIViewControllerRepresentable that shows the default iOS share sheet
    /// with some details on how to install the current app.
    /// - Parameter app: The app to use for showing in the download message.
    init(app: AKMyApp) {
        self.app = app
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheetView>) -> UIActivityViewController {
        let message = String(localized: "Check out \(app.name) on the App Store!", bundle: .module)
        return UIActivityViewController(activityItems: [app.appStoreURL, message], applicationActivities: nil)
    }
    
    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ShareSheetView>
    ) {}
}
#endif
