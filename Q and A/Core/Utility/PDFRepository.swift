//
//  PDFRepository.swift
//  Q and A
//
//  Created by GIGL-PC on 08/07/2026.
//

import Foundation

final class PDFRepository {

    func cachedFile(for url: URL) -> URL? {

        if PDFCacheManager.shared.exists(remoteURL: url) {

            return PDFCacheManager.shared.cachedFile(for: url)

        }

        return nil

    }

}
