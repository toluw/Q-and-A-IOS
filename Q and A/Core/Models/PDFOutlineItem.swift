//
//  PDFOutlineItem.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import Foundation
import PDFKit


struct PDFOutlineItem: Identifiable {
    let id = UUID()
    let label: String
    let destination: PDFDestination?
    let children: [PDFOutlineItem]

    var hasChildren: Bool { !children.isEmpty }
}
