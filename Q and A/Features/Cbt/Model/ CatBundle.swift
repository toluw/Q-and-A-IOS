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
    let originalPrice: Int
    let price: Int
    let discountedPrice: Int
    let sellerEmail: String?

    enum CodingKeys: String, CodingKey {
        case bundleId = "bundle_id"
        case bundleTitle = "bundle_title"
        case bundleContent = "bundle_content"
        case originalPrice = "original_price"
        case price
        case discountedPrice = "discounted_price"
        case sellerEmail = "seller_email"
    }
}
