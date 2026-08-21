//
//  PaymentResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation

struct PaymentResponse: Codable{
    
    let data: UserPaymentData
}

struct UserPaymentData: Codable{
   let page: Int
    let total_pages: Int
    let page_size: Int
    let items: [Payment]
}




