//
//  WatchItemLabel.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2022.
//

#if os(watchOS)
import SwiftUI

struct ItemLabel: View {
    private let title: String
    private let details: String

    init(_ title: String, details: String) {
        self.title = title
        self.details = details
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)

            Text(details)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}

#Preview {
    ItemLabel("Title", details: "Details")
}
#endif
