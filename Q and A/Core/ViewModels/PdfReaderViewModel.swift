//
//  PdfReaderViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 08/07/2026.
//

import Foundation

final class PdfReaderViewModel: ObservableObject {

    let fileURL: URL

    init(fileURL: URL) {

        self.fileURL = fileURL

    }

}
