//
//  File.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation

struct LoginResponse: Decodable {
    let status: Bool?
    let message: String?
    let data: UserData?
    
    struct UserData: Decodable {
        let firstname: String
        let lastname: String
        let email: String
        let phone: String?
        let library: [Library]?
        let image: String?
    }
    
    struct Library: Decodable {
        let title: String
        let url: String
        let location: String
        let file: String
    }
}
