//
//  AKSection.swift
//  AboutKit
//

/// A section displayed in the AboutKit form.
public enum AKSection {
    case header
    case contact
    case developerProfiles
    case appProfiles
    case sharingAndReview
    case legalAndAcknowledgements
    case testFlight
    case otherApps
    case custom(title: String? = nil, _ entries: [AKEntry])

    /// The section order used when no custom order is supplied.
    public static var defaultOrder: [AKSection] {
        [
            .header,
            .contact,
            .developerProfiles,
            .appProfiles,
            .sharingAndReview,
            .legalAndAcknowledgements,
            .testFlight,
            .otherApps
        ]
    }
}
