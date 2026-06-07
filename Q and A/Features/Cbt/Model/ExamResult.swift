//
//  ExamResult.swift
//  Q and A
//
//  Created by GIGL-PC on 03/05/2026.
//

import Foundation

struct ExamResult: Codable, Equatable, Hashable {
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
    
    static let preview = ExamResult(item: "Exam 1", examId: "1", numQuestions: 10, shouldShuffle: true, category: "Science", image: nil, examTime: 100, score: 80, createAt: "03/05/2026", disableReview: false, timeDuration: 100, endTime: "03/05/2026")

    func getNumCorrectAnswers() -> Int {
        let correctAns = score * Double(numQuestions) / 100.0
        return Int(correctAns)
    }
}
