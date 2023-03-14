//
//  MacContinueButton.swift
//  AboutKit
//
//  Created by Adam Foot on 14/03/2023.
//

#if os(macOS)
import SwiftUI

struct ContinueButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStrings.continueButton)
                .padding(.horizontal)
                .frame(minWidth: 200)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

struct ContinueButton_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButton {
            print("Tapped")
        }
        .padding()
    }
}
#endif
