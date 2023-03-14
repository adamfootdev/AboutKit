//
//  FeaturesView.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

#if os(iOS) || os(macOS) || os(tvOS)
import SwiftUI

/// A SwiftUI view which displays a list of featured items.
public struct FeaturesView: View {
    @Environment(\.dismiss) private var dismiss

    @Namespace private var featuresNamespace

    /// The string to display at the top of the view
    /// e.g. What's New, What's New in App or Welcome to App.
    private let title: String

    /// An array of featured items to display in a scrollable list.
    private let featureItems: [AKFeatureItem]

    /// A Boolean indicating whether the continue button should be shown.
    private let showContinueButton: Bool

    /// An optional completion block to perform when the Continue button is tapped.
    private let continueAction: (() -> Void)?

    /// Initializes a new SwiftUI view which displays a list of featured items.
    /// - Parameters:
    ///   - title: The string to display at the top of the view
    ///   e.g. What's New, What's New in App or Welcome to App.
    ///   - featureItems: An array of featured items to display in a scrollable list.
    ///   - showContinueButton: A Boolean indicating whether the continue button should be shown.
    ///   - continueAction: An optional completion block to perform when the Continue button is tapped.
    public init(
        title: String,
        featureItems: [AKFeatureItem],
        showContinueButton: Bool = true,
        continueAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.featureItems = featureItems
        self.showContinueButton = showContinueButton
        self.continueAction = continueAction
    }
    
    public var body: some View {
        VStack(spacing: titleContentSpacing) {
            Text(title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding([.top, .horizontal], 40)
                .accessibilityAddTraits(.isHeader)

            VStack(spacing: 16) {
                FeaturesListView(featureItems)

                if showContinueButton {
                    ContinueButton {
                        dismiss()

                        if let continueAction = continueAction {
                            continueAction()
                        }
                    }
                    #if os(tvOS)
                    .prefersDefaultFocus(true, in: featuresNamespace)
                    #endif
                    .padding(.horizontal, horizontalPadding)
                    .padding(.vertical, verticalPadding)
                }
            }
            #if os(tvOS)
            .focusScope(featuresNamespace)
            #endif
            .padding(.bottom, showContinueButton ? 0 : verticalPadding)
        }
    }

    private var titleContentSpacing: CGFloat {
        #if os(tvOS)
        return 80
        #else
        return 40
        #endif
    }

    private var horizontalPadding: CGFloat {
        #if os(tvOS)
        return 500
        #else
        return 28
        #endif
    }

    private var verticalPadding: CGFloat {
        #if os(tvOS)
        return 20
        #else
        return 28
        #endif
    }
}

struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView(
            title: "What's New",
            featureItems: [
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
