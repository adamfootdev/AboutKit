//
//  AboutAppWithNavigationView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

import SwiftUI

/// A SwiftUI view with navigation bar that displays attributes and links relating to an app.
public struct AboutAppWithNavigationView: View {
    /// A custom struct containing details about the current app.
    private let app: AKApp

    /// An array of custom structs that contain details about other apps the developer owns.
    private let otherApps: [AKOtherApp]

    /// The type of navigation title to show.
    private let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    
    @Environment(\.presentationMode) var presentationMode

    /// Initializes a new SwiftUI view with navigation bar that displays attributes and links relating to an app.
    /// - Parameters:
    ///   - app: A custom struct containing details about the current app.
    ///   - otherApps: An array of custom structs that contain details about other apps the developer owns.
    ///   - titleDisplayMode: The type of navigation title to show. Defaults to inline.
    public init(
        app: AKApp,
        otherApps: [AKOtherApp],
        titleDisplayMode: NavigationBarItem.TitleDisplayMode = .inline
    ) {
        self.app = app
        self.otherApps = otherApps
        
        self.titleDisplayMode = titleDisplayMode
    }
    
    private var doneToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(LocalizedStrings.done, action: dismiss)
        }
    }
    
    public var body: some View {
        NavigationView {
            AboutAppView(app: app, otherApps: otherApps)
                .navigationBarTitle(LocalizedStrings.about, displayMode: titleDisplayMode)
                .toolbar {
                    doneToolbarItem
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AboutAppWithNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppWithNavigationView(
            app: AKApp.example,
            otherApps: [AKOtherApp.example, AKOtherApp.example]
        )
    }
}
