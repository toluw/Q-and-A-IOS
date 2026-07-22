//
//  UpdatePostBody.swift
//  Q and A
//
//  Created by GIGL-PC on 22/07/2026.
//

import Foundation

struct UpdatePostBody: Codable{
    
    let post_id: String
    let content: String
    let image: String?
    let title: String
    var expiry: String? = nil
    var link: String = ""
    
}
