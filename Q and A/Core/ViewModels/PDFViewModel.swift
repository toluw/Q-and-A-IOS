//
//  PDFViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import Foundation
import PDFKit

final class PDFViewModel: NSObject, ObservableObject {
    let pdfView = PDFView()
    @Published var outlineItems: [PDFOutlineItem] = []
    @Published var currentPage: Int = 1
    @Published var pageCount: Int = 0

    func load(url: URL) {
        let document = PDFDocument(url: url)
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical

        pageCount = document?.pageCount ?? 0

        if let root = document?.outlineRoot {
            outlineItems = buildOutline(from: root)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(pageChanged),
            name: .PDFViewPageChanged,
            object: pdfView
        )

        updateCurrentPage()
    }

    @objc private func pageChanged() {
        updateCurrentPage()
    }

    private func updateCurrentPage() {
        guard let document = pdfView.document,
              let page = pdfView.currentPage else { return }
        currentPage = document.index(for: page) + 1
    }

    private func buildOutline(from outline: PDFOutline) -> [PDFOutlineItem] {
        (0..<outline.numberOfChildren).compactMap { index in
            guard let child = outline.child(at: index) else { return nil }
            return PDFOutlineItem(
                label: child.label ?? "Untitled",
                destination: child.destination,
                children: buildOutline(from: child)
            )
        }
    }

    func navigate(to destination: PDFDestination?) {
        guard let destination else { return }
        pdfView.go(to: destination)
    }

    /// pageNumber is 1-based, as shown to the user
    func goToPage(_ pageNumber: Int) {
        guard let document = pdfView.document,
              pageNumber >= 1, pageNumber <= document.pageCount,
              let page = document.page(at: pageNumber - 1) else { return }
        pdfView.go(to: page)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
