//
//  CreateCommentBody.swift
//  Q and A
//
//  Created by GIGL-PC on 05/08/2026.
//

import Foundation

struct CreateCommentBody: Codable{
    let post_id: String
    let email: String
    let content: String
    var image: String? = nil
}
