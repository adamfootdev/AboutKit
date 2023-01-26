//
//  FeatureItemRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

#if os(iOS)
import SwiftUI

struct FeatureItemRowView: View {
    var item: AKFeatureItem
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: item.systemImage)
                .resizable()
                .scaledToFit()
                .foregroundColor(item.imageTint)
                .frame(width: 30, height: 30)
                .accessibilityElement(children: .ignore)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)

                Text(item.description)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct FeatureItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureItemRowView(item: .example)
    }
}
#endif
