//
//  MacItemLabel.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2023.
//

#if os(macOS)
import SwiftUI

struct ItemLabel: View {
    private let title: String
    private let actionTitle: String
    private let action: () -> Void

    init(
        _ title: String,
        actionTitle: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button(actionTitle, action: action)
        }
    }
}

#Preview {
    Form {
        ItemLabel("Title", actionTitle: "Action") {}
    }
    .formStyle(.grouped)
}
#endif
