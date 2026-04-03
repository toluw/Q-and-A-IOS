//
//  LoginRequest.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation


struct LoginRequest: Encodable {
    let email: String
    let password: String
    let token: String
    let deviceId: String
    let isAndroid: String = "0"
    
    // Maps Swift naming (camelCase) to API naming (snake_case)
    enum CodingKeys: String, CodingKey {
        case email, password, token
        case deviceId = "device_id"
        case isAndroid = "is_android"
    }
}
