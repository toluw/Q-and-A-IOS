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
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

