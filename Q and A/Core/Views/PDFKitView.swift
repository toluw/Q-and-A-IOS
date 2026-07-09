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

    @ObservedObject var viewModel: PDFViewModel

    func makeUIView(context: Context) -> PDFView {

        viewModel.pdfView

    }

    func updateUIView(
        _ uiView: PDFView,
        context: Context
    ) {

    }

}
