//
//  DeleteCommentBody.swift
//  Q and A
//
//  Created by GIGL-PC on 05/08/2026.
//

import Foundation

struct DeleteCommentBody: Codable{
    
      let comment_id: String
      let reason: String
      let is_admin: Bool
    
}
