//
//  AskAiCbtResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 24/06/2026.
//

import Foundation

struct AskAiCbtResponse: Codable{
    let status: Bool
    let message: String
    let data: AskAiData
}

struct AskAiData: Codable{
    let content: String
}
