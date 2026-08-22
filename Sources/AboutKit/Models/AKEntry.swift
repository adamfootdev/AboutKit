//
//  AKEntry.swift
//  AboutKit
//

import SwiftUI

/// A custom row that presents a SwiftUI view from an AboutKit section.
public struct AKEntry: View {

    /// The way an entry presents its destination.
    enum Presentation: Equatable {
        /// Pushes the destination onto the current navigation stack.
        case navigation

        /// Presents the destination in a sheet.
        case sheet
    }

    /// The way this entry presents its destination.
    let presentation: Presentation

    /// The title displayed in the row.
    let title: String

    /// The name of the SF Symbol displayed alongside the title.
    let systemImage: String

    /// The type erased destination presented by the row.
    private let destination: AnyView

    private init(
        presentation: Presentation,
        title: String,
        systemImage: String,
        destination: AnyView
    ) {
        self.presentation = presentation
        self.title = title
        self.systemImage = systemImage
        self.destination = destination
    }

    /// Creates a row that pushes its destination onto the current navigation stack.
    /// - Parameters:
    ///   - title: The title displayed in the row.
    ///   - systemImage: The name of the SF Symbol displayed alongside the title.
    ///   - destination: A view builder producing the view to push.
    @MainActor
    public static func navigation<Destination: View>(
        _ title: String,
        systemImage: String,
        @ViewBuilder destination: () -> Destination
    ) -> AKEntry {
        AKEntry(
            presentation: .navigation,
            title: title,
            systemImage: systemImage,
            destination: AnyView(destination())
        )
    }

    /// Creates a row that presents its destination in a sheet.
    /// - Parameters:
    ///   - title: The title displayed in the row.
    ///   - systemImage: The name of the SF Symbol displayed alongside the title.
    ///   - destination: A view builder producing the view to present.
    @MainActor
    public static func sheet<Destination: View>(
        _ title: String,
        systemImage: String,
        @ViewBuilder destination: () -> Destination
    ) -> AKEntry {
        AKEntry(
            presentation: .sheet,
            title: title,
            systemImage: systemImage,
            destination: AnyView(destination())
        )
    }

    @ViewBuilder
    public var body: some View {
        #if os(macOS)
        // The macOS form has no navigation stack to push onto, so every entry
        // presents its destination in a sheet regardless of its presentation.
        AKSheetEntry(
            title: title,
            systemImage: systemImage,
            destination: destination
        )
        #else
        switch presentation {
        case .navigation:
            NavigationLink {
                destination
            } label: {
                AKEntryLabel(title: title, systemImage: systemImage)
            }

        case .sheet:
            AKSheetEntry(
                title: title,
                systemImage: systemImage,
                destination: destination
            )
        }
        #endif
    }
}

private struct AKSheetEntry: View {
    let title: String
    let systemImage: String
    let destination: AnyView

    @State private var isPresented = false

    var body: some View {
        row
            .sheet(isPresented: $isPresented) {
                destination
            }
    }

    @ViewBuilder
    private var row: some View {
        #if os(macOS)
        // Matches the built-in macOS rows, which are a title alongside a
        // trailing action button and carry no symbol.
        ItemLabel(title, actionTitle: LocalizedStrings.viewMac) {
            isPresented = true
        }
        #else
        Button {
            isPresented = true
        } label: {
            AKEntryLabel(title: title, systemImage: systemImage)
        }
        #endif
    }
}

#if !os(macOS)
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
#endif

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
        #if os(macOS)
        .formStyle(.grouped)
        #endif
    }
}
