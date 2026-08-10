//
//  CreateReplyBody.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import Foundation

struct CreateReplyBody: Codable{
    
    let comment_id: String
    let email: String
    let content: String
    let image: String
    var quote_id: String = "0"
    
}
