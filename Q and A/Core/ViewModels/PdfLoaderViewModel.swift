//
//  PdfLoaderViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 08/07/2026.
//

import Foundation

@MainActor
final class PdfLoaderViewModel:
ObservableObject,
@MainActor PDFDownloaderDelegate {

    @Published var progress: Double = 0

    @Published var error: String?

    @Published var completedURL: URL?

    private let downloader = PDFDownloader()

    init() {

        downloader.delegate = self

    }

    func start(url: URL) {

        let destination =
            PDFCacheManager.shared.cachedFile(for: url)

        downloader.download(
            from: url,
            destination: destination
        )

    }

    func progress(_ progress: Double) {

        self.progress = progress

    }

    func finished(localURL: URL) {

        completedURL = localURL

    }

    func failed(error: Error) {

        self.error = error.localizedDescription

    }

}
