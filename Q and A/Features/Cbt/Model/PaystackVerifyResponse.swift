//
//  PaystackVerifyResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 18/05/2026.
//

import Foundation





struct PaystackVerifyResponse: Codable{
    let data: VerifyData
}



struct VerifyData: Codable{
    let status: String
    let gateway_response: String?
    let currency: String
    let amount: Int
    
}
