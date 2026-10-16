//
//  ValidateCodeResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import Foundation

struct ValidateCodeResponse: Codable{
    let status: Bool
    let message: String
    let agent: Agent
}
