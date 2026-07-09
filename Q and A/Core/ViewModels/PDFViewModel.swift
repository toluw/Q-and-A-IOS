//
//  PDFViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import Foundation
import PDFKit

final class PDFViewModel: ObservableObject {
    let pdfView = PDFView()
    @Published var outlineItems: [PDFOutlineItem] = []

    func load(url: URL) {
        let document = PDFDocument(url: url)
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical

        if let root = document?.outlineRoot {
            outlineItems = buildOutline(from: root)
        }
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
}
