//
//  ContinueButton.swift
//  AboutKit
//
//  Created by Adam Foot on 24/02/2021.
//

import SwiftUI

struct ContinueButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(LocalizedStrings.continueButton)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
        .background(Color.accentColor)
        .cornerRadius(15)
    }
}

struct ContinueButton_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButton {
            print("Tapped")
        }
    }
}
