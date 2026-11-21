//
//  WhatsappCommunity.swift
//  Q and A
//
//  Created by GIGL-PC on 15/11/2026.
//

import Foundation

struct WhatsappCommunity: Codable {
    let show_notification: Bool
    let reason: String
    let traction_id: Int?
    let community_id: Int?
    let offer_id: Int?
    let title: String?
    let link: String?
    let message: String?
    let views_since_last_notice: Int?
    let views_remaining: Int?
}
