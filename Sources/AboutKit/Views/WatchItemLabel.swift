//
//  WatchItemLabel.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2022.
//

#if os(watchOS)
import SwiftUI

struct WatchItemLabel: View {
    private let titleKey: LocalizedStringKey?
    private let title: String?
    private let details: String
    
    init(_ titleKey: LocalizedStringKey, details: String) {
        self.titleKey = titleKey
        self.title = nil
        self.details = details
    }
    
    init(_ title: String, details: String) {
        self.titleKey = nil
        self.title = title
        self.details = details
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let titleKey = titleKey {
                    Text(titleKey)
                } else if let title = title {
                    Text(title)
                } else {
                    Text("")
                }
            }
            .font(.caption.bold())
            .foregroundColor(.secondary)
            
            Text(details)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowBackground(Color.clear)
    }
}

struct WatchItemLabel_Previews: PreviewProvider {
    static var previews: some View {
        WatchItemLabel("Title", details: "Details")
    }
}
#endif
