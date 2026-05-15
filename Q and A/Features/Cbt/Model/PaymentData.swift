//
//  PaymentData.swift
//  Q and A
//
//  Created by GIGL-PC on 15/05/2026.
//

import Foundation

struct PaymentData: Codable {
    
    let title: String
    let paymentType: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "display_name"
        case paymentType = "variable_name"
        case category = "value"
    }
}
