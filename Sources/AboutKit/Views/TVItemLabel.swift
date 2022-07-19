//
//  TVItemLabel.swift
//  AboutKit
//
//  Created by Adam Foot on 13/05/2022.
//

#if os(tvOS)
import SwiftUI

struct ItemLabel: View {
    private let title: String
    private let details: String

    init(_ title: String, details: String) {
        self.title = title
        self.details = details
    }

    var body: some View {
        // Adding an empty button here so that the row can be highlighted
        // in a SwiftUI form.
        Button {
        } label: {
            HStack {
                Text(title)
                Spacer()

                Text(details)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ItemLabel_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ItemLabel("Title", details: "Details")
        }
    }
}
#endif
