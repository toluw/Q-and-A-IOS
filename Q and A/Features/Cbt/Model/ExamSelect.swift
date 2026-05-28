//
//  ExamSelect.swift
//  Q and A
//
//  Created by GIGL-PC on 02/05/2026.
//

import Foundation

struct ExamSelect{
    var item: String
    var exam: Exam
    var numQuestions: Int
    var shouldShuffle: Bool
    var category: String
    var image: String?
    var disableReview: Bool
    var endTime: String = ""
    
    func getExamTime() -> Int {
           
           let totalTime = exam.duration
           let totalQuestions = exam.numQuestions
           let selectedQuestions = numQuestions
           
           let ratio = Double(selectedQuestions) / Double(totalQuestions)
           
           let result = ratio * Double(totalTime)
           
           return Int(result.rounded())
       }
}
