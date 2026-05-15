//
//  InititateTransactionResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 15/05/2026.
//

import Foundation



struct InititateTransactionResponse{
   
    let data: InitiateTransactionData
    
}






struct InitiateTransactionData: Codable{
    let authorization_url: String
    let access_code: String
    let reference: String
}
