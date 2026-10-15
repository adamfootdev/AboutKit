//
//  AKEmailAttachment.swift
//  AboutKit
//

import Foundation
import UniformTypeIdentifiers
#if os(macOS)
import AppKit
#endif

/// Content that AboutKit can attach to a support email.
public enum AKEmailAttachment {
    /// A local file. AboutKit reads the file immediately before opening the email composer.
    case file(URL, fileName: String? = nil, mimeType: String? = nil)

    /// UTF-8 text attached as a plain-text file.
    case text(String, fileName: String)

    /// An image attached as a PNG file.
    case image(PlatformImage, fileName: String)

    /// Arbitrary data attached unchanged with the supplied MIME type.
    case binary(Data, mimeType: String, fileName: String)
}

struct AKPreparedEmailAttachment {
    let data: Data
    let mimeType: String
    let fileName: String
}

extension Array where Element == AKEmailAttachment {
    @MainActor
    func preparedForEmail() async -> [AKPreparedEmailAttachment] {
        var fileNames: Set<String> = []
        var result: [AKPreparedEmailAttachment] = []

        for attachment in self {
            guard Task.isCancelled == false,
                  let prepared = await attachment.preparedForEmail(),
                  fileNames.insert(prepared.fileName).inserted else { continue }

            result.append(prepared)
        }

        return result
    }
}

private extension AKEmailAttachment {
    @MainActor
    func preparedForEmail() async -> AKPreparedEmailAttachment? {
        switch self {
        case .file(let url, let customFileName, let customMIMEType):
            return await Self.prepareFile(
                at: url,
                fileName: customFileName,
                mimeType: customMIMEType
            )

        case .text(let text, let fileName):
            guard Self.isValid(fileName: fileName) else { return nil }
            return AKPreparedEmailAttachment(
                data: Data(text.utf8),
                mimeType: "text/plain",
                fileName: fileName
            )

        case .image(let image, let fileName):
            guard Self.isValid(fileName: fileName),
                  URL(fileURLWithPath: fileName).pathExtension.lowercased() == "png",
                  let data = image.pngDataForEmail else { return nil }

            return AKPreparedEmailAttachment(
                data: data,
                mimeType: "image/png",
                fileName: fileName
            )

        case .binary(let data, let mimeType, let fileName):
            guard Self.isValid(fileName: fileName),
                  Self.isValid(mimeType: mimeType) else { return nil }
            return AKPreparedEmailAttachment(
                data: data,
                mimeType: mimeType,
                fileName: fileName
            )
        }
    }

    static func prepareFile(
        at url: URL,
        fileName customFileName: String?,
        mimeType customMIMEType: String?
    ) async -> AKPreparedEmailAttachment? {
        await Task.detached {
            guard url.isFileURL else { return nil }

            let fileName = customFileName ?? url.lastPathComponent
            guard isValid(fileName: fileName) else { return nil }

            let mimeType: String
            if let customMIMEType {
                guard isValid(mimeType: customMIMEType) else { return nil }
                mimeType = customMIMEType
            } else {
                mimeType = UTType(filenameExtension: url.pathExtension)?.preferredMIMEType
                    ?? "application/octet-stream"
            }

            let accessedSecurityScopedResource = url.startAccessingSecurityScopedResource()
            defer {
                if accessedSecurityScopedResource {
                    url.stopAccessingSecurityScopedResource()
                }
            }

            guard let resourceValues = try? url.resourceValues(forKeys: [.isRegularFileKey]),
                  resourceValues.isRegularFile == true,
                  let data = try? Data(contentsOf: url) else { return nil }

            return AKPreparedEmailAttachment(
                data: data,
                mimeType: mimeType,
                fileName: fileName
            )
        }.value
    }

    static func isValid(fileName: String) -> Bool {
        fileName.isEmpty == false
            && fileName != "."
            && fileName != ".."
            && URL(fileURLWithPath: fileName).lastPathComponent == fileName
    }

    static func isValid(mimeType: String) -> Bool {
        let parts = mimeType.split(separator: "/", omittingEmptySubsequences: false)
        return parts.count == 2 && parts.allSatisfy { $0.isEmpty == false }
    }
}

private extension PlatformImage {
    var pngDataForEmail: Data? {
        #if os(macOS)
        guard let tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmap.representation(using: .png, properties: [:])
        #else
        return pngData()
        #endif
    }
}
