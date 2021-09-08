//
//  ListButtonLabel.swift
//  AboutKit
//
//  Created by Adam Foot on 08/09/2021.
//

import SwiftUI

struct ListButtonLabel: View {
    private let titleKey: LocalizedStringKey?
    private let title: String?
    private let image: String?
    private let systemImage: String?

    init(_ titleKey: LocalizedStringKey, image name: String) {
        self.titleKey = titleKey
        self.title = nil
        self.image = name
        self.systemImage = nil
    }

    init(_ title: String, image name: String) {
        self.titleKey = nil
        self.title = title
        self.image = name
        self.systemImage = nil
    }

    init(_ titleKey: LocalizedStringKey, systemImage name: String) {
        self.titleKey = titleKey
        self.title = nil
        self.image = nil
        self.systemImage = name
    }

    init(_ title: String, systemImage name: String) {
        self.titleKey = nil
        self.title = title
        self.image = nil
        self.systemImage = name
    }

    var body: some View {
        Label {
            Group {
                if let titleKey = titleKey {
                    Text(titleKey)
                } else if let title = title {
                    Text(title)
                } else {
                    Text("")
                }
            }
            .foregroundColor(.primary)

        } icon: {
            Group {
                if let image = image {
                    Image(image)
                } else if let systemImage = systemImage {
                    Image(systemName: systemImage)
                } else {
                    Image(systemName: "questionmark")
                }
            }
            .foregroundColor(.accentColor)
        }
    }
}

struct ListButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ListButtonLabel("Email", systemImage: "envelope")
    }
}
