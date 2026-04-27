//
//  SubCatExamsResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 18/04/2026.
//

import Foundation

struct SubCatExamsResponse: Codable {
    
    
    let status: Bool
    let message: String
    let data: [SubCategoryData]
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
        case message
    }
    

}

struct SubCategoryData: Codable, Equatable {
    
    let cbtId: String
    let item: String
    let createdAt: String
    let isActive: Bool
    let subcatId: String
    var exams: [Exam]
    var id: String {cbtId}
    
    enum CodingKeys: String, CodingKey {
        case cbtId = "cbt_id"
        case item
        case createdAt = "created_at"
        case isActive = "is_active"
        case subcatId = "subcat_id"
        case exams
    }
}
