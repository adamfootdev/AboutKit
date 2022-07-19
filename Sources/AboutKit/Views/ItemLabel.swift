//
//  ItemLabel.swift
//  AboutKit
//
//  Created by Adam Foot on 08/09/2021.
//

#if os(iOS)
import SwiftUI

struct ItemLabel: View {
    private let title: String
    private let systemImage: String

    init(_ title: String, systemImage name: String) {
        self.title = title
        self.systemImage = name
    }

    var body: some View {
        Label {
            Text(title)
                .foregroundColor(.primary)

        } icon: {
            Image(systemName: systemImage)
                .foregroundColor(.accentColor)
        }
    }
}

struct ListButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ItemLabel("Email", systemImage: "envelope")
    }
}
#endif
