//
//  PaymentDetailsResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation

struct PaymentDetailsResponse: Codable{
    
    let status: Bool
    let message: String
    let data: [PaymentDetail]
    
}

struct PaymentDetail: Codable{
    let title: String
}
