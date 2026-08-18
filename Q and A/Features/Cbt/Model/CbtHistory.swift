//
//  CbtHistory.swift
//  Q and A
//
//  Created by GIGL-PC on 18/08/2026.
//

import Foundation

struct CbtHistory: Codable, Equatable, Identifiable, Hashable  {
    let id: String
    let item: String
    let numQuestions: String
    let examId: String
    let shouldShuffle: String
    let category: String
    let image: String
    let examTime: String
    let score: String
    let buyerEmail: String
    let createdAt: String
    let isCompleted: String
    let disableReview: Bool
    let timeDuration: String
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case id
        case item
        case numQuestions = "num_questions"
        case examId = "exam_id"
        case shouldShuffle = "should_shuffle"
        case category
        case image
        case examTime = "exam_time"
        case score
        case buyerEmail = "buyer_email"
        case createdAt = "created_at"
        case isCompleted = "is_completed"
        case disableReview = "disable_review"
        case timeDuration = "time_duration"
        case endTime = "end_time"
    }
}
