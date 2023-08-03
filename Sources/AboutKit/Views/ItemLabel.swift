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
    private let systemImageName: String?
    private let imageName: String?

    init(_ title: String, systemImage name: String) {
        self.title = title
        self.systemImageName = name
        self.imageName = nil
    }

    init(_ title: String, image name: String) {
        self.title = title
        self.systemImageName = nil
        self.imageName = name
    }

    var body: some View {
        Label {
            Text(title)
                .foregroundStyle(Color.primary)

        } icon: {
            Group {
                if let systemImageName {
                    Image(systemName: systemImageName)
                } else if let imageName {
                    Image(imageName, bundle: .module)
                } else {
                    Image(systemName: "circle")
                }
            }
            .foregroundStyle(Color.accentColor)
        }
    }
}

struct ListButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ItemLabel("Email", systemImage: "envelope")
            ItemLabel("Twitter", image: "twitter")
        }
    }
}
#endif
