//
//  AcknowledgementsView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/08/2023.
//

import SwiftUI

struct AcknowledgementsView: View {
    @Environment(\.dismiss) private var dismiss

    private let acknowledgments: AKAcknowledgements

    init(_ acknowledgments: AKAcknowledgements) {
        self.acknowledgments = acknowledgments
    }

    var body: some View {
        #if os(macOS)
        NavigationStack {
            acknowledgementsForm
                .toolbar {
                    doneToolbarItem
                }
        }
        .frame(minWidth: 400, minHeight: 300)

        #else
        acknowledgementsForm
        #endif
    }

    private var acknowledgementsForm: some View {
        Form {
            if let people = acknowledgments.people {
                Section {
                    ForEach(Array(people.enumerated()), id: \.0) { index, person in
                        NavigationLink {
                            PersonAcknowledgementView(person)
                        } label: {
                            #if os(iOS) || os(visionOS)
                            Label(person.name, systemImage: "person")
                            #else
                            Text(person.name)
                            #endif
                        }
                        .id("person-\(index)")
                    }

                } header: {
                    Text(LocalizedStrings.people)
                }
            }

            if let frameworks = acknowledgments.frameworks {
                Section {
                    ForEach(Array(frameworks.enumerated()), id: \.0) { index, acknowledgment in
                        NavigationLink {
                            FrameworkAcknowledgementView(acknowledgment)
                        } label: {
                            #if os(iOS) || os(visionOS)
                            Label(acknowledgment.name, systemImage: "square.stack.3d.up")
                            #else
                            Text(acknowledgment.name)
                            #endif
                        }
                        .id("framework-\(index)")
                    }

                } header: {
                    Text(LocalizedStrings.frameworks)
                }
            }
        }
        #if os(macOS)
        .formStyle(.grouped)
        #endif
        .navigationTitle(LocalizedStrings.acknowledgements)
        #if os(iOS) || os(visionOS) || os(watchOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var doneToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(LocalizedStrings.done) {
                dismiss()
            }
        }
    }
}

#Preview {
    AcknowledgementsView(.example)
}
