//
//  CbtHistoryResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 18/08/2026.
//

import Foundation

struct CbtHistoryResponse: Codable{
    let data: CbtHistoryData
    let status: Bool
    let message: String
}

struct CbtHistoryData: Codable{
    let page: Int
    let total_pages: Int
    let page_size: Int
    let items: [CbtHistory]
}
