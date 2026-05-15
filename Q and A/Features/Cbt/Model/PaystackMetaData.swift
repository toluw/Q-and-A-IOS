//
//  PaymentMetaData.swift
//  Q and A
//
//  Created by GIGL-PC on 15/05/2026.
//

import Foundation

struct PaystackMetaData: Codable{
    let custiomFields: [PaymentData]
    
    enum CodingKeys: String, CodingKey {
        case custiomFields = "custom_fields"
       
    }
}
