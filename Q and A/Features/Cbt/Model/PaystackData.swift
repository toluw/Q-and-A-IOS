//
//  PaystackData.swift
//  Q and A
//
//  Created by GIGL-PC on 15/05/2026.
//

import Foundation

struct PaystackData: Codable{
    
    let amount: String
    let email: String
    let metadata: PaystackMetaData
    var reference: String? = nil
    var callback_url: String = paystack_callback
    
}
