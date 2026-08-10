//
//  DeleteReplyBody.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import Foundation

struct DeleteReplyBody: Codable{
    
    let reply_id: String
    let reason: String
    let is_admin: Bool
    
}
