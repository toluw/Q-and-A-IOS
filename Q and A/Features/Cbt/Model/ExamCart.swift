//
//  ExamCart.swift
//  Q and A
//
//  Created by GIGL-PC on 09/05/2026.
//

import Foundation
import SwiftData



@Model
final class ExamCart{
    
    var cbtId: String
        var subcatId: String
        var numQuestions: Int
        var price: Int
        var title: String
        var instruction: String
        var examDescription: String
        var duration: Int
        var isActive: Bool
        var createdAt: String
        var sellerEmail: String
        var hasSample: Bool

        @Attribute(.unique)
        var examId: String

        var isProvisioned: Bool
        var numViews: Int
        var isMaxAttempt: Bool
        var startTime: String
        var isCompulsory: String

        init(
            cbtId: String,
            subcatId: String,
            numQuestions: Int,
            price: Int,
            title: String,
            instruction: String,
            examDescription: String,
            duration: Int,
            isActive: Bool,
            createdAt: String,
            sellerEmail: String,
            hasSample: Bool,
            examId: String,
            isProvisioned: Bool,
            numViews: Int,
            isMaxAttempt: Bool,
            startTime: String,
            isCompulsory: String
        ) {
            self.cbtId = cbtId
            self.subcatId = subcatId
            self.numQuestions = numQuestions
            self.price = price
            self.title = title
            self.instruction = instruction
            self.examDescription = examDescription
            self.duration = duration
            self.isActive = isActive
            self.createdAt = createdAt
            self.sellerEmail = sellerEmail
            self.hasSample = hasSample
            self.examId = examId
            self.isProvisioned = isProvisioned
            self.numViews = numViews
            self.isMaxAttempt = isMaxAttempt
            self.startTime = startTime
            self.isCompulsory = isCompulsory
        }
    
    func toExam() -> Exam {
        Exam(cbtId: cbtId, subcatId: subcatId, numQuestions: numQuestions, price: price, title: title, instruction: instruction, description: examDescription, duration: duration, isActive: isActive, createdAt: createdAt, sellerEmail: sellerEmail, hasSample: hasSample, examId: examId, isProvisioned: isProvisioned, numViews: numViews, isMaxAttempt: isMaxAttempt, startTime: startTime, isCompulsory: isCompulsory)
    }
    
}
