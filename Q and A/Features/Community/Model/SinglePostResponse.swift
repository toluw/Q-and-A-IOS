//
//  SinglePostResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 06/08/2026.
//

import Foundation

struct SinglePostResponse: Codable{
    
    let data: Post
    let status: Bool
    let message: String
    
}
