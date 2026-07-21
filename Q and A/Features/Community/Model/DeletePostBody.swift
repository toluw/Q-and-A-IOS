//
//  DeletePostBody.swift
//  Q and A
//
//  Created by GIGL-PC on 21/07/2026.
//

import Foundation

struct DeletePostBody: Codable{
    
    let post_id: String
    var reason: String = ""
    var is_admin: Bool = false
    
}
