import Foundation

struct CartExam: Codable, Equatable {

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

    var examId: String

    var isProvisioned: Bool
    var numViews: Int
    var isMaxAttempt: Bool
    var startTime: String
    var isCompulsory: String

    func toExam() -> Exam {
        Exam(cbtId: cbtId, subcatId: subcatId, numQuestions: numQuestions, price: price, title: title, instruction: instruction, description: examDescription, duration: duration, isActive: isActive, createdAt: createdAt, sellerEmail: sellerEmail, hasSample: hasSample, examId: examId, isProvisioned: isProvisioned, numViews: numViews, isMaxAttempt: isMaxAttempt, startTime: startTime, isCompulsory: isCompulsory)
    }

}
