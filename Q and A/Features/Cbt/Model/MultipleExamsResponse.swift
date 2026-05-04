//
//  MultipleExamsResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 04/05/2026.
//

import Foundation

struct MultipleExamsResponse: Codable {
    let data: [MultipleExamData]
    let status: Bool
    let message: String

    struct MultipleExamData: Codable, Equatable {
        let examId: String
        let item: String
        let examData: [ExamData]

        enum CodingKeys: String, CodingKey {
            case examId = "exam_id"
            case item
            case examData = "exam_data"
        }
    }
}
