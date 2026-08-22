//
//  AKEntry.swift
//  AboutKit
//

import SwiftUI

/// A custom row that presents a SwiftUI view from an AboutKit section.
public enum AKEntry {
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
}
