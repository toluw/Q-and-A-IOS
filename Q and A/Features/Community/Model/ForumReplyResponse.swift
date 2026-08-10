//
//  ForumReplyResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import Foundation

struct ForumReplyResponse: Codable{
    let status: Bool
    let message: String
    let data: ForumReplyData
}

struct ForumReplyData: Codable{
    let page: Int
    let total_pages: Int
    let page_size: Int
    let items: [Reply]
}
