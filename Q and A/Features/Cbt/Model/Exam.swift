//
//  Exam.swift
//  Q and A
//
//  Created by GIGL-PC on 18/04/2026.
//

import Foundation

struct Exam: Codable, Equatable, Identifiable {
    
    let cbtId: String
    let subcatId: String
    let numQuestions: Int
    let price: Int
    var title: String
    let instruction: String
    let description: String
    let duration: Int
    let isActive: Bool
    let createdAt: String
    let sellerEmail: String
    let hasSample: Bool
    let examId: String
    let isProvisioned: Bool
    let numViews: Int
    let isMaxAttempt: Bool
    let startTime: String
    let isCompulsory: String
    var id: String {examId}
    
    enum CodingKeys: String, CodingKey {
        case cbtId = "cbt_id"
        case subcatId = "subcat_id"
        case numQuestions = "num_questions"
        case price
        case title
        case instruction
        case description
        case duration
        case isActive = "is_active"
        case createdAt = "created_at"
        case sellerEmail = "seller_email"
        case hasSample = "has_sample"
        case examId = "exam_id"
        case isProvisioned = "is_provisioned"
        case numViews = "num_views"
        case isMaxAttempt = "is_max_attempts"
        case startTime = "start_time"
        case isCompulsory = "is_compulsory"
    }
}
