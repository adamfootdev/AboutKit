//
//  AKEntry.swift
//  AboutKit
//

import SwiftUI

/// Custom SwiftUI content displayed inline or presented from an AboutKit section.
public struct AKEntry: View {

    /// The way an entry presents its destination.
    enum Presentation: Equatable {
        /// Pushes the destination onto the current navigation stack.
        case navigation

        /// Presents the destination in a sheet.
        case sheet

        /// Displays the content directly inside the section.
        case inline
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

    /// Displays custom content directly inside the section on every platform.
    /// - Parameter content: A view builder producing the inline content.
    @MainActor
    public static func inline<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> AKEntry {
        AKEntry(
            presentation: .inline,
            title: "",
            systemImage: "",
            destination: AnyView(content())
        )
    }

    @ViewBuilder
    public var body: some View {
        switch presentation {
        case .inline:
            destination

        case .navigation:
            #if os(macOS)
            // The macOS form has no navigation stack, so navigation entries
            // present their destination in a sheet.
            AKSheetEntry(
                title: title,
                systemImage: systemImage,
                destination: destination
            )
            #else
            NavigationLink {
                destination
            } label: {
                AKEntryLabel(title: title, systemImage: systemImage)
            }
            #endif

        case .sheet:
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
        row
            .sheet(isPresented: $isPresented) {
                #if os(macOS)
                // A macOS sheet is sized by its content, which leaves flexible
                // destinations such as forms and lists too small. The floor
                // matches the built-in acknowledgements sheet, and a
                // destination setting its own frame still wins.
                destination
                    .frame(minWidth: 400, minHeight: 300)
                #else
                destination
                #endif
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
