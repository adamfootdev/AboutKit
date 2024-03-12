//
//  FrameworkAcknowledgementView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/08/2023.
//

import SwiftUI

struct FrameworkAcknowledgementView: View {
    @Environment(\.openURL) private var openURL

    private let acknowledgment: AKFrameworkAcknowledgement

    init(_ acknowledgment: AKFrameworkAcknowledgement) {
        self.acknowledgment = acknowledgment
    }

    var body: some View {
        Form {
            if let links = acknowledgment.links,
               links.isEmpty == false {
                Section {
                    ForEach(Array(links.enumerated()), id: \.0) { _, link in
                        #if os(iOS) || os(visionOS)
                        Button {
                            openURL(link.url)
                        } label: {
                            ItemLabel(
                                link.title,
                                systemImage: link.systemImage
                            )
                        }

                        #elseif os(macOS)
                        ItemLabel(link.title, actionTitle: LocalizedStrings.viewMac) {
                            openURL(link.url)
                        }

                        #elseif os(tvOS) || os(watchOS)
                        ItemLabel(
                            link.title,
                            details: link.url.absoluteString
                        )
                        #endif
                    }
                } header: {
                    Text(LocalizedStrings.links)
                }
            }

            if let details = acknowledgment.details {
                Section {
                    Text(details)
                        .lineLimit(nil)
                        #if os(iOS) || os(visionOS)
                        .font(.system(.subheadline, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowInsets(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
                        #elseif os(macOS)
                        .font(.system(.subheadline, design: .monospaced))
                        #elseif os(tvOS) || os(watchOS)
                        .font(.system(.caption2, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowBackground(Color.clear)
                        #endif
                } header: {
                    Text(LocalizedStrings.details)
                }
            }
        }
        #if os(macOS)
        .formStyle(.grouped)
        #endif
        .navigationTitle(acknowledgment.name)
        #if os(iOS) || os(watchOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct FrameworkAcknowledgementView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkAcknowledgementView(.example)
    }
}
