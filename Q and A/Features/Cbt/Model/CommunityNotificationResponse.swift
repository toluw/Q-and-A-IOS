//
//  CommunityNotificationResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 15/11/2026.
//

import Foundation

struct CommunityNotificationResponse: Codable{
    let status: Bool
    let message: String
    let data: WhatsappCommunity
    
}
