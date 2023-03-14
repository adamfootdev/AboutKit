//
//  WelcomeView.swift
//  AboutKit
//
//  Created by Adam Foot on 23/02/2021.
//

#if os(iOS)
import SwiftUI

/// A SwiftUI view which displays a list of featured items beneath some large Welcome to App text.
public struct WelcomeView: View {
    @Environment(\.dismiss) private var dismiss

    /// The app that is being used to display the welcome view.
    private let app: AKMyApp

    /// An array of featured items to display in a scrollable list.
    private let featureItems: [AKFeatureItem]

    /// A Boolean indicating whether the continue button should be shown.
    private let showContinueButton: Bool

    /// An optional completion block to perform when the Continue button is tapped.
    private let continueAction: (() -> Void)?

    /// Initializes a new SwiftUI view which displays a list of featured items beneath some large Welcome to App text.
    /// - Parameters:
    ///   - app: The app that is being used to display the welcome view.
    ///   - featureItems: An array of featured items to display in a scrollable list.
    ///   - showContinueButton: A Boolean indicating whether the continue button should be shown.
    ///   - continueAction: An optional completion block to perform when the Continue button is tapped.
    public init(
        app: AKMyApp,
        featureItems: [AKFeatureItem],
        showContinueButton: Bool = true,
        continueAction: (() -> Void)? = nil
    ) {
        self.app = app
        self.featureItems = featureItems
        self.showContinueButton = showContinueButton
        self.continueAction = continueAction
    }

    public var body: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading) {
                Text(LocalizedStrings.welcomeTo)

                Text(app.name)
                    .foregroundColor(.accentColor)
            }
            .font(.system(size: 48, weight: .heavy))
            .padding([.top, .horizontal], 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)
            
            FeaturesListView(featureItems)

            if showContinueButton {
                ContinueButton {
                    dismiss()

                    if let continueAction = continueAction {
                        continueAction()
                    }
                }
                .padding(28)
            }
        }
        .padding(.bottom, showContinueButton ? 0 : 28)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(
            app: AKMyApp.example,
            featureItems: [
                AKFeatureItem.example,
                AKFeatureItem.example,
                AKFeatureItem.example,
                AKFeatureItem.example,
                AKFeatureItem.example,
                AKFeatureItem.example
            ]
        ) {
            print("Done")
        }
    }
}
#endif
