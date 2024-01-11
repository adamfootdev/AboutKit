//
//  PersonAcknowledgementView.swift
//  AboutKit
//
//  Created by Adam Foot on 14/08/2023.
//

import SwiftUI

struct PersonAcknowledgementView: View {
    @Environment(\.openURL) private var openURL

    private let acknowledgment: AKPersonAcknowledgement

    init(_ acknowledgment: AKPersonAcknowledgement) {
        self.acknowledgment = acknowledgment
    }

    var body: some View {
        Form {
            if let profiles = acknowledgment.profiles,
               profiles.isEmpty == false {
                Section {
                    ForEach(Array(profiles.enumerated()), id: \.0) { _, profile in
                        #if os(iOS) || os(visionOS)
                        Button {
                            openURL(profile.url)
                        } label: {
                            ItemLabel(
                                profile.title,
                                image: profile.platform.imageName
                            )
                        }

                        #elseif os(macOS)
                        ItemLabel(profile.title, actionTitle: LocalizedStrings.viewProfile) {
                            openURL(profile.url)
                        }

                        #elseif os(tvOS) || os(watchOS)
                        ItemLabel(
                            profile.platform.name,
                            details: profile.displayUsername
                        )
                        #endif
                    }
                } header: {
                    Text(LocalizedStrings.profiles)
                }
            }

            Section {
                Text(acknowledgment.details)
                    .lineLimit(nil)
                    #if os(iOS) || os(visionOS)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .listRowInsets(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
                    #elseif os(macOS)
                    .font(.subheadline)
                    #elseif os(tvOS) || os(watchOS)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .listRowBackground(Color.clear)
                    #endif
            } header: {
                Text(LocalizedStrings.details)
            }
        }
        #if os(macOS)
        .formStyle(.grouped)
        #endif
        .navigationTitle(acknowledgment.name)
        #if os(iOS) || os(visionOS) || os(watchOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct PersonAcknowledgementView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonAcknowledgementView(.example)
        }
        #if os(iOS)
        .navigationViewStyle(.stack)
        #endif
    }
}
