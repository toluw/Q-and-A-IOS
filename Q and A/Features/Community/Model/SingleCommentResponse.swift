//
//  SingleCommentResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import Foundation

struct SingleCommentResponse: Codable{
    let status: Bool
    let message: String
    let data: Comment
    
}
