//
//  PostResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import Foundation

struct PostResponse: Codable {
    let status: Bool
    let message: String
    let data: Data

    struct Data: Codable {
        let page: Int
        let totalPages: Int
        let pageSize: Int
        let items: [Post]

        enum CodingKeys: String, CodingKey {
            case page
            case totalPages = "total_pages"
            case pageSize = "page_size"
            case items
        }
    }
}
