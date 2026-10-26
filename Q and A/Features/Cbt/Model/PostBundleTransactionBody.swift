//
//  PostBundleTransactionBody.swift
//  Q and A
//
//  Created by GIGL-PC on 18/10/2026.
//

import Foundation

struct PostBundleTransactionBody: Codable {
    let buyerEmail: String
    let reference: String
    let isAndroid: String
    let processor: Int
    let code: String?
    let data: [BundlePost]

    enum CodingKeys: String, CodingKey {
        case buyerEmail = "buyer_email"
        case reference
        case isAndroid = "is_android"
        case processor
        case code
        case data
    }
}

struct BundlePost: Codable {
    let bundleId: String

    enum CodingKeys: String, CodingKey {
        case bundleId = "bundle_id"
    }
}
