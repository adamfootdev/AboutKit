//
//  URLSession+Sendable.swift
//  AboutKit
//
//  Created by Adam Foot on 01/05/2024.
//

import Foundation

extension URLSession {
    nonisolated func getData(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request)
    }

    nonisolated func getData(for url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url)
    }
}
