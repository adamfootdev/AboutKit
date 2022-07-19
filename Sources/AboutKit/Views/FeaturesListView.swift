//
//  FeaturesListView.swift
//  AboutKit
//
//  Created by Adam Foot on 19/07/2022.
//

import SwiftUI

#if os(iOS)
struct FeaturesListView: View {
    private let featureItems: [AKFeatureItem]

    init(_ featureItems: [AKFeatureItem]) {
        self.featureItems = featureItems
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                ForEach(featureItems, content: FeatureItemRowView.init)
            }
            .padding(.horizontal, 40)
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
