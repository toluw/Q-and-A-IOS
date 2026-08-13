//
//  SocialLoginBody.swift
//  Q and A
//
//  Created by GIGL-PC on 13/08/2026.
//

import Foundation

struct SocialLoginBody: Codable{
    let token: String
    let device_id: String
    let apple_id: String
    let email: String?
}
