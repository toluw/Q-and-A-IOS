//
//  ParentBundleIdResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import Foundation


struct ParentBundleIdResponse: Codable{
    let status: Bool
    let message: String
    let data: CatBundle?
    
}
