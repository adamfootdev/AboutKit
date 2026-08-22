//
//  AKEntryRow.swift
//  AboutKit
//

import SwiftUI

struct AKEntryRow: View {
    private let entry: AKEntry

    @State private var showingSheet = false

    init(_ entry: AKEntry) {
        self.entry = entry
    }

    var body: some View {
        switch entry {
        case .navigation(let title, let systemImage, let destination):
            NavigationLink {
                destination
            } label: {
                label(title, systemImage: systemImage)
            }

        case .sheet(let title, let systemImage, let destination):
            Button {
                showingSheet = true
            } label: {
                label(title, systemImage: systemImage)
            }
            .sheet(isPresented: $showingSheet) {
                destination
            }
        }
    }

    @ViewBuilder
    private func label(_ title: String, systemImage: String) -> some View {
        #if os(iOS) || os(visionOS)
        ItemLabel(title, systemImage: systemImage)
        #else
        Label(title, systemImage: systemImage)
        #endif
    }
}

#Preview {
    NavigationStack {
        Form {
            Section("Custom") {
                AKEntryRow(.navigation("Navigation", systemImage: "arrow.right") {
                    Text("Navigation destination")
                })

                AKEntryRow(.sheet("Sheet", systemImage: "rectangle.portrait") {
                    Text("Sheet destination")
                })
            }
        }
    }
}
