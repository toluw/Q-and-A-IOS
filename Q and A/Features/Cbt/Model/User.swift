//
//  User.swift
//  Q and A
//
//  Created by GIGL-PC on 13/07/2026.
//

import Foundation

struct User: Codable {
    let created: String
    let deviceId: String
    let email: String
    let id: String
    let name: String
    let phone: String
    let token: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case created
        case deviceId = "device_id"
        case email
        case id
        case name
        case phone
        case token
        case image
    }
}
