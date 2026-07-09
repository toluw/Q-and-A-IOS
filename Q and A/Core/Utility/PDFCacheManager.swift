//
//  PDFCacheManager.swift
//  Q and A
//
//  Created by GIGL-PC on 08/07/2026.
//

import Foundation
import CryptoKit

final class PDFCacheManager {

    static let shared = PDFCacheManager()

    private init() {}

    private let folderName = "CachedPDFs"

    /// App-private storage location
    private var cacheDirectory: URL {

        let fileManager = FileManager.default

        let applicationSupport = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first!

        let directory = applicationSupport.appendingPathComponent(folderName)

        if !fileManager.fileExists(atPath: directory.path) {

            do {
                try fileManager.createDirectory(
                    at: directory,
                    withIntermediateDirectories: true
                )

                // Exclude downloaded files from iCloud backup
                var values = URLResourceValues()
                values.isExcludedFromBackup = true

                var mutableDirectory = directory
                try mutableDirectory.setResourceValues(values)

            } catch {
                print("Failed to create PDF cache directory: \(error)")
            }
        }

        return directory
    }

    /// Returns where a PDF should be stored.
    func cachedFile(for remoteURL: URL) -> URL {

        let hash = SHA256.hash(data: Data(remoteURL.absoluteString.utf8))

        let filename = hash.map {
            String(format: "%02x", $0)
        }.joined()

        return cacheDirectory.appendingPathComponent("\(filename).pdf")
    }

    /// Checks if a cached PDF already exists.
    func exists(remoteURL: URL) -> Bool {

        FileManager.default.fileExists(
            atPath: cachedFile(for: remoteURL).path
        )
    }

    /// Removes a cached PDF.
    func remove(remoteURL: URL) throws {

        let url = cachedFile(for: remoteURL)

        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }

    /// Clears all cached PDFs.
    func clearAll() throws {

        let files = try FileManager.default.contentsOfDirectory(
            at: cacheDirectory,
            includingPropertiesForKeys: nil
        )

        for file in files {
            try FileManager.default.removeItem(at: file)
        }
    }
}
