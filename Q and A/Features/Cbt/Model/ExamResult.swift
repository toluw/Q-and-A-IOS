//
//  ExamResult.swift
//  Q and A
//
//  Created by GIGL-PC on 03/05/2026.
//

import Foundation

struct ExamResult: Codable {
    var item: String
    var examId: String
    var numQuestions: Int
    var shouldShuffle: Bool
    var category: String
    var image: String?
    var examTime: Int
    var score: Double
    var createAt: String
    var disableReview: Bool
    var timeDuration: Int
    var endTime: String

    func getNumCorrectAnswers() -> Int {
        let correctAns = score * Double(numQuestions) / 100.0
        return Int(correctAns)
    }
}
