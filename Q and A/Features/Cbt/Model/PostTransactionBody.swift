//
//  PostTransactionBody.swift
//  Q and A
//
//  Created by GIGL-PC on 17/05/2026.
//

import Foundation


struct PostTransactionBody: Codable{
    
    let buyer_email: String
    let reference: String
    let exams: [Transaction]
    var is_android: String = "0"
    let processor: Int
    
    
}


struct Transaction: Codable{
    
    let exam_id: String
    let seller_email: String
    let price: Int
    
}
