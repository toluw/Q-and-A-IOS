//
//  UnfinishedResultBody.swift
//  Q and A
//
//  Created by GIGL-PC on 09/06/2026.
//

import Foundation

struct UnfinishedResultBody: Codable {
    let item: String
    let numQuestions: Int
    let examId: Int
    let shouldShuffle: Bool
    let category: String
    let image: String?
    let examTime: Int
    let score: Double
    let buyerEmail: String
    let isCompleted: Bool
    let disableReview: Bool
    let timeDuration: Int
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case item
        case numQuestions = "num_questions"
        case examId = "exam_id"
        case shouldShuffle = "should_shuffle"
        case category
        case image
        case examTime = "exam_time"
        case score
        case buyerEmail = "buyer_email"
        case isCompleted = "is_completed"
        case disableReview = "disable_review"
        case timeDuration = "time_duration"
        case endTime = "end_time"
    }
}
