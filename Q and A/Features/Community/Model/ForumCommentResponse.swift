//
//  ForumCommentResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 04/08/2026.
//

import Foundation

struct ForumCommentResponse: Codable{
    let status: Bool
    let message: String
    let data: ForumCommentData
}

struct ForumCommentData: Codable{
    let page: Int
    let total_pages: Int
    let page_size: Int
    let items: [Comment]
}
