//
//  FeatureItemRowView.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

import SwiftUI

struct FeatureItemRowView: View {
    var item: AKFeatureItem
    
    var body: some View {
        HStack {
            Image(systemName: item.systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(item.imageTint)
                .padding(.trailing, 15)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.description)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity)
    }
}

struct FeatureItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureItemRowView(item: AKFeatureItem.example)
    }
}
