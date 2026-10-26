//
//  GetUserBundleResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 15/10/2026.
//

import Foundation

struct GetUserBundleResponse: Codable{
    let status: Bool
    let message: String
    let data: BundledData
    
}

struct BundledData: Codable{
    let description: String
    let data: [UserBundle]
}
