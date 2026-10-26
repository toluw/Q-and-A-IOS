import Foundation
import SwiftData

// Keep the existing SwiftData entity and default store on iOS 17 and later.
@available(iOS 17.0, *)
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

    func toCartExam() -> CartExam {
        CartExam(cbtId: cbtId,
                subcatId: subcatId,
                numQuestions: numQuestions,
                price: price,
                title: title,
                instruction: instruction,
                examDescription: examDescription,
                duration: duration,
                isActive: isActive,
                createdAt: createdAt,
                sellerEmail: sellerEmail,
                hasSample: hasSample,
                examId: examId,
                isProvisioned: isProvisioned,
                numViews: numViews,
                isMaxAttempt: isMaxAttempt,
                startTime: startTime,
                isCompulsory: isCompulsory)
    }

    convenience init(item: CartExam) {
        self.init(cbtId: item.cbtId,
                subcatId: item.subcatId,
                numQuestions: item.numQuestions,
                price: item.price,
                title: item.title,
                instruction: item.instruction,
                examDescription: item.examDescription,
                duration: item.duration,
                isActive: item.isActive,
                createdAt: item.createdAt,
                sellerEmail: item.sellerEmail,
                hasSample: item.hasSample,
                examId: item.examId,
                isProvisioned: item.isProvisioned,
                numViews: item.numViews,
                isMaxAttempt: item.isMaxAttempt,
                startTime: item.startTime,
                isCompulsory: item.isCompulsory)
    }
}
