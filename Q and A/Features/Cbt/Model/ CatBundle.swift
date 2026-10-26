//
//   CatBundle.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import Foundation

struct CatBundle: Codable {
    let bundleId: String?
    let bundleTitle: String
    let bundleContent: String

    enum CodingKeys: String, CodingKey {
        case bundleId = "bundle_id"
        case bundleTitle = "bundle_title"
        case bundleContent = "bundle_content"
    }
}
