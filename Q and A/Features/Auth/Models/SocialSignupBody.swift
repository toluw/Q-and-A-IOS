//
//  SocialSignupBody.swift
//  Q and A
//
//  Created by GIGL-PC on 14/08/2026.
//

import Foundation

struct SocialSignupBody: Codable{
    
    let name: String
    let email: String
    let phone: String
    let token: String
    let device_id: String
    let apple_id: String?
    
}
