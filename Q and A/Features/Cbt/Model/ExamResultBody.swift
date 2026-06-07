//
//  ExamResultBody.swift
//  Q and A
//
//  Created by GIGL-PC on 07/06/2026.
//

import Foundation

struct ExamResultBody: Codable {
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
    let resultData: [ExamResultBodyData]
    let disableReview: Bool
    let timeDuration: Int
    let endTime: String
    let cbtId: String
    
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
        case resultData = "result_data"
        case disableReview = "disable_review"
        case timeDuration = "time_duration"
        case endTime = "end_time"
        case cbtId = "cbt_id"
    }
}





struct ExamResultBodyData: Codable{
        let question: String
        let numberOfAnswer: Int
        let answer: String
        let passage: String
        let a: String
        let b: String
        let c: String
        let d: String
        let e: String
        let explanation: String
        let questionId: Int
        let questionImage: String?
        let passageImage: String?
        let aImage: String?
        let bImage: String?
        let cImage: String?
        let dImage: String?
        let eImage: String?
        let explanationImage: String?
        let solution: String
        let passageVideo: String?
        let passageBook: String?
        
        enum CodingKeys: String, CodingKey {
            case question
            case numberOfAnswer = "number_of_answer"
            case answer
            case passage
            case a, b, c, d, e
            case explanation
            case questionId = "question_id"
            case questionImage = "question_image"
            case passageImage = "passage_image"
            case aImage = "a_image"
            case bImage = "b_image"
            case cImage = "c_image"
            case dImage = "d_image"
            case eImage = "e_image"
            case explanationImage = "explanation_image"
            case solution
            case passageVideo = "passage_video"
            case passageBook = "passage_book"
        }
}
