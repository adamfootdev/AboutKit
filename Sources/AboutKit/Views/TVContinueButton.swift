//
//  TVContinueButton.swift
//  AboutKit
//
//  Created by Adam Foot on 11/11/2022.
//

#if os(tvOS)
import SwiftUI

struct ContinueButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStrings.continueButton)
                .font(.headline)
                .frame(maxWidth: .infinity)
        }
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
