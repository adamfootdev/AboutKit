//
//  AKEntry.swift
//  AboutKit
//

import SwiftUI

/// A custom row that presents a SwiftUI view from an AboutKit section.
public enum AKEntry: View {
    /// A row that pushes its destination onto the current navigation stack.
    case navigation(
        title: String,
        systemImage: String,
        destination: AnyView
    )

    /// A row that presents its destination in a sheet.
    case sheet(
        title: String,
        systemImage: String,
        destination: AnyView
    )

    /// Creates a row that pushes its destination onto the current navigation stack.
    @MainActor
    public static func navigation<Destination: View>(
        _ title: String,
        systemImage: String,
        @ViewBuilder destination: () -> Destination
    ) -> AKEntry {
        .navigation(
            title: title,
            systemImage: systemImage,
            destination: AnyView(destination())
        )
    }

    /// Creates a row that presents its destination in a sheet.
    @MainActor
    public static func sheet<Destination: View>(
        _ title: String,
        systemImage: String,
        @ViewBuilder destination: () -> Destination
    ) -> AKEntry {
        .sheet(
            title: title,
            systemImage: systemImage,
            destination: AnyView(destination())
        )
    }

    @ViewBuilder
    public var body: some View {
        switch self {
        case .navigation(let title, let systemImage, let destination):
            NavigationLink {
                destination
            } label: {
                AKEntryLabel(title: title, systemImage: systemImage)
            }

        case .sheet(let title, let systemImage, let destination):
            AKSheetEntry(
                title: title,
                systemImage: systemImage,
                destination: destination
            )
        }
    }
}

private struct AKSheetEntry: View {
    let title: String
    let systemImage: String
    let destination: AnyView

    @State private var isPresented = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            AKEntryLabel(title: title, systemImage: systemImage)
        }
        .sheet(isPresented: $isPresented) {
            destination
        }
    }
}

private struct AKEntryLabel: View {
    let title: String
    let systemImage: String

    var body: some View {
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
                AKEntry.navigation("Navigation", systemImage: "arrow.right") {
                    Text("Navigation destination")
                }

                AKEntry.sheet("Sheet", systemImage: "rectangle.portrait") {
                    Text("Sheet destination")
                }
            }
        }
    }
}
