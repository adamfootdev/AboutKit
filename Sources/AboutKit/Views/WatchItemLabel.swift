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
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption.bold())
                .foregroundColor(.secondary)
            
            Text(details)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowBackground(Color.clear)
    }
}

struct ItemLabel_Previews: PreviewProvider {
    static var previews: some View {
        ItemLabel("Title", details: "Details")
    }
}
#endif
