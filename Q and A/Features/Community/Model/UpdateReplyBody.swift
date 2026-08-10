//
//  UpdateReplyBody.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import Foundation

struct UpdateReplyBody: Codable{
    
    let reply_id: String
    let content: String
    let image: String?
    
}
