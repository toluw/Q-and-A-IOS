//
//  MultipleExamsBody.swift
//  Q and A
//
//  Created by GIGL-PC on 04/05/2026.
//

import Foundation

struct MultipleExamsBody: Codable {
    let buyerEmail: String
    let exams: [ExamBody]

    struct ExamBody: Codable {
        let examId: String
        let item: String

        enum CodingKeys: String, CodingKey {
            case examId = "exam_id"
            case item
        }
    }

    enum CodingKeys: String, CodingKey {
        case buyerEmail = "buyer_email"
        case exams
    }
}
