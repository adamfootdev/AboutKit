//
//  FeaturesView.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

#if os(iOS)
import SwiftUI

/// A SwiftUI view which displays a list of featured items.
public struct FeaturesView: View {
    @Environment(\.dismiss) private var dismiss

    /// The string to display at the top of the view
    /// e.g. What's New, What's New in App or Welcome to App.
    private let title: String

    /// An array of featured items to display in a scrollable list.
    private let featureItems: [AKFeatureItem]

    /// An optional completion block to perform when the Continue button is tapped.
    private let continueAction: (() -> Void)?

    /// Initializes a new SwiftUI view which displays a list of featured items.
    /// - Parameters:
    ///   - title: The string to display at the top of the view
    ///   e.g. What's New, What's New in App or Welcome to App.
    ///   - featureItems: An array of featured items to display in a scrollable list.
    ///   - continueAction: An optional completion block to perform when the Continue button is tapped.
    public init(
        title: String,
        featureItems: [AKFeatureItem],
        continueAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.featureItems = featureItems
        self.continueAction = continueAction
    }
    
    public var body: some View {
        VStack(spacing: 40) {
            Text(title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding([.top, .horizontal], 40)

            VStack(spacing: 16) {
                FeaturesListView(featureItems)

                ContinueButton {
                    dismiss()

                    if let continueAction = continueAction {
                        continueAction()
                    }
                }
                .padding(28)
            }
        }
    }
}

struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView(
            title: "What's New",
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
