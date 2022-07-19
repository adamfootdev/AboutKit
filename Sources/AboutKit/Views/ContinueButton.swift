//
//  ContinueButton.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

#if os(iOS)
import SwiftUI

struct ContinueButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(LocalizedStrings.continueButton)
                .font(.headline)
                .frame(maxWidth: .infinity)
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
    }
}
#endif
