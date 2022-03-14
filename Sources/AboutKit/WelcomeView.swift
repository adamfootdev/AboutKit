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
    /// The app that is being used to display the welcome view.
    private let app: AKApp

    /// An array of featured items to display in a scrollable list.
    private let featureItems: [AKFeatureItem]

    /// An optional completion block to perform when the Continue button is tapped.
    private let onContinueAction: (() -> Void)?
    
    @Environment(\.presentationMode) var presentationMode

    /// Initializes a new SwiftUI view which displays a list of featured items beneath some large Welcome to App text.
    /// - Parameters:
    ///   - app: The app that is being used to display the welcome view.
    ///   - featureItems: An array of featured items to display in a scrollable list.
    ///   - onContinueAction: An optional completion block to perform when the Continue button is tapped.
    public init(
        app: AKApp,
        featureItems: [AKFeatureItem],
        onContinueAction: (() -> Void)? = nil
    ) {
        self.app = app
        self.featureItems = featureItems
        self.onContinueAction = onContinueAction
    }
    
    private var title: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStrings.welcomeTo)
            
            Text(app.name)
                .foregroundColor(.accentColor)
        }
        .font(.system(size: 50, weight: .heavy))
        .padding([.horizontal, .bottom], 40)
        .padding(.top, 50)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    public var body: some View {
        VStack {
            title
            
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(
            app: AKApp.example,
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
