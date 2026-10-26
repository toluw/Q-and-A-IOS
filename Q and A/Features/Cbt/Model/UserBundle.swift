//
//  UserBundle.swift
//  Q and A
//
//  Created by GIGL-PC on 15/10/2026.
//

import Foundation

struct UserBundle: Codable {
    let item: String
    let bundleId: String
    let price: Int
    let originalPrice: Int
    let discountedPrice: Int
    let sellerEmail: String

    enum CodingKeys: String, CodingKey {
        case item
        case bundleId = "bundle_id"
        case price
        case originalPrice = "original_price"
        case discountedPrice = "discounted_price"
        case sellerEmail = "seller_email"
    }
}
