//
//  CreatePostBody.swift
//  Q and A
//
//  Created by GIGL-PC on 22/07/2026.
//

import Foundation

struct CreatePostBody: Codable{
    
    let exam_id: String
    let question_id: String
    let email: String
    let content: String
    var image: String? = nil
    
    
}
