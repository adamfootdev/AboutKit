//
//  TVFeatureItemRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 11/11/2022.
//

#if os(tvOS)
import SwiftUI

struct FeatureItemRowView: View {
    var item: AKFeatureItem

    var body: some View {
        HStack(spacing: 40) {
            Image(systemName: item.systemImage)
                .resizable()
                .scaledToFit()
                .foregroundColor(item.imageTint)
                .frame(width: 60, height: 60)

            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.title3.bold())

                Text(item.description)
                    .font(.headline)
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
