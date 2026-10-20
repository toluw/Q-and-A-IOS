//
//  BanksResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 20/10/2026.
//

import Foundation


struct BanksResponse: Codable {
    let status: Bool?
    let message: String?
    let data: [BankData]?

   
}


struct BankData: Codable, Identifiable {
    let name: String
    let slug: String
    let code: String
    let longcode: String
    let gateway: String
    let payWithBank: Bool
    let active: Bool
    let isDeleted: Bool
    let country: String
    let currency: String
    let type: String
    let id: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case name
        case slug
        case code
        case longcode
        case gateway
        case payWithBank = "pay_with_bank"
        case active
        case isDeleted = "is_deleted"
        case country
        case currency
        case type
        case id
        case createdAt
        case updatedAt
    }
}

