//
//  SectionHeaderLabel.swift
//  AboutKit
//
//  Created by Adam Foot on 19/10/2023.
//

#if os(tvOS)
import SwiftUI

struct SectionHeaderLabel: View {
    private let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .textCase(nil)
            .font(.body.bold())
            .foregroundStyle(.secondary)
            .padding(.top, 20)
            .padding(.bottom, 4)
    }
}

struct SectionHeaderLabel_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section {
                Text("Content")
            } header: {
                SectionHeaderLabel("Title")
            }
        }
    }
}
#endif
