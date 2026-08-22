import XCTest
@testable import AboutKit
import SwiftUI

final class AboutKitTests: XCTestCase {
    func testDefaultSectionOrder() {
        let sectionNames = AKSection.defaultOrder.map { section in
            switch section {
            case .header: "header"
            case .contact: "contact"
            case .developerProfiles: "developerProfiles"
            case .appProfiles: "appProfiles"
            case .sharingAndReview: "sharingAndReview"
            case .legalAndAcknowledgements: "legalAndAcknowledgements"
            case .testFlight: "testFlight"
            case .otherApps: "otherApps"
            case .custom: "custom"
            }
        }

        XCTAssertEqual(
            sectionNames,
            [
                "header",
                "contact",
                "developerProfiles",
                "appProfiles",
                "sharingAndReview",
                "legalAndAcknowledgements",
                "testFlight",
                "otherApps"
            ]
        )

        MainActor.assumeIsolated {
            XCTAssertEqual(AKConfiguration.example.sections.count, sectionNames.count)
        }
    }

    func testCustomSectionEntries() {
        MainActor.assumeIsolated {
            let navigationEntry = AKEntry.navigation(
                "Purchases",
                systemImage: "cart"
            ) {
                Text("Purchases")
            }

            let sheetEntry = AKEntry.sheet(
                "Tip Jar",
                systemImage: "heart"
            ) {
                Text("Tip Jar")
            }

            let section = AKSection.custom(
                title: "Support",
                [navigationEntry, sheetEntry]
            )

            guard case .custom(let title, let entries) = section else {
                return XCTFail("Expected a custom section")
            }

            XCTAssertEqual(title, "Support")
            XCTAssertEqual(entries.count, 2)

            guard case .navigation(let title, let systemImage, _) = entries[0] else {
                return XCTFail("Expected a navigation entry")
            }

            XCTAssertEqual(title, "Purchases")
            XCTAssertEqual(systemImage, "cart")

            guard case .sheet(let title, let systemImage, _) = entries[1] else {
                return XCTFail("Expected a sheet entry")
            }

            XCTAssertEqual(title, "Tip Jar")
            XCTAssertEqual(systemImage, "heart")

            let untitledSection = AKSection.custom([navigationEntry])

            guard case .custom(let title, let entries) = untitledSection else {
                return XCTFail("Expected an untitled custom section")
            }

            XCTAssertNil(title)
            XCTAssertEqual(entries.count, 1)
        }
    }

    static let allTests = [
        ("testDefaultSectionOrder", testDefaultSectionOrder),
        ("testCustomSectionEntries", testCustomSectionEntries),
    ]
}
