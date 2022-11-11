//
//  TVFeaturesListView.swift
//  AboutKit
//
//  Created by Adam Foot on 11/11/2022.
//

#if os(tvOS)
import SwiftUI

struct FeaturesListView: View {
    private let featureItems: [AKFeatureItem]

    init(_ featureItems: [AKFeatureItem]) {
        self.featureItems = featureItems
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 60) {
                ForEach(featureItems, content: FeatureItemRowView.init)
            }
            .padding(.horizontal, 400)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct FeaturesListView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesListView([
            AKFeatureItem.example,
            AKFeatureItem.example,
            AKFeatureItem.example,
            AKFeatureItem.example,
            AKFeatureItem.example,
            AKFeatureItem.example
        ])
    }
}
#endif
