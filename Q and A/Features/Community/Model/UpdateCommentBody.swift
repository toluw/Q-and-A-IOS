//
//  UpdateCommentBody.swift
//  Q and A
//
//  Created by GIGL-PC on 05/08/2026.
//

import Foundation

struct UpdateCommentBody: Codable{
    let content: String
    let comment_id: String
    var image: String? = nil
}
