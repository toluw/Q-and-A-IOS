//
//  InititateTransactionResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 15/05/2026.
//

import Foundation



struct InititateTransactionResponse: Codable{
   
    let data: InitiateTransactionData
    let status: Bool
    let message: String
    
}






struct InitiateTransactionData: Codable, Equatable{
    let authorization_url: String
    let access_code: String
    let reference: String
}
