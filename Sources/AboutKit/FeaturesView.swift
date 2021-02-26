//
//  FeaturesView.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

import SwiftUI

/// A SwiftUI view which displays a list of featured items.
public struct FeaturesView: View {
    /// The string to display at the top of the view
    /// e.g. What's New, What's New in App or Welcome to App.
    private let title: String

    /// An array of featured items to display in a scrollable list.
    private let featureItems: [AKFeatureItem]

    /// An optional completion block to perform when the Continue button is tapped.
    private let onContinueAction: (() -> Void)?
    
    @Environment(\.presentationMode) var presentationMode

    /// Initializes a new SwiftUI view which displays a list of featured items.
    /// - Parameters:
    ///   - title: The string to display at the top of the view
    ///   e.g. What's New, What's New in App or Welcome to App.
    ///   - featureItems: An array of featured items to display in a scrollable list.
    ///   - onContinueAction: An optional completion block to perform when the Continue button is tapped.
    public init(title: String, featureItems: [AKFeatureItem], onContinueAction: (() -> Void)?) {
        self.title = title
        self.featureItems = featureItems
        self.onContinueAction = onContinueAction
    }
    
    public var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 36, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(40)
            
            ScrollView {
                VStack {
                    ForEach(featureItems, content: FeatureItemRowView.init)
                }
            }
            
            ContinueButton(action: closeView)
                .padding(40)
        }
    }
    
    private func closeView() {
        presentationMode.wrappedValue.dismiss()
        
        if let onContinueAction = onContinueAction {
            onContinueAction()
        }
    }
}

struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView(
            title: "What's New",
            featureItems: [AKFeatureItem.example, AKFeatureItem.example, AKFeatureItem.example, AKFeatureItem.example, AKFeatureItem.example, AKFeatureItem.example]
        ) {
            print("Done")
        }
    }
}
