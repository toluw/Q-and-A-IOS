//
//  PDFKitView.swift
//  Q and A
//
//  Created by GIGL-PC on 08/07/2026.
//

import Foundation

import PDFKit
import SwiftUI

struct PDFKitView: UIViewRepresentable {

    let fileURL: URL

    func makeUIView(context: Context) -> PDFView {

        let view = PDFView()

        view.autoScales = true

        view.displayMode = .singlePageContinuous

        view.displayDirection = .vertical

        view.document = PDFDocument(url: fileURL)

        return view

    }

    func updateUIView(
        _ uiView: PDFView,
        context: Context
    ) {

    }

}
