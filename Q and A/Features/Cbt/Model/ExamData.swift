//
//  ExamData.swift
//  Q and A
//
//  Created by GIGL-PC on 04/05/2026.
//

import Foundation

struct ExamData: Codable, Equatable {
    let question: String
    let passage: String
    let a: String
    let b: String
    let c: String
    let d: String
    let e: String
    let numberOfAnswer: Int
    let answer: String
    let explanation: String
    let questionId: String
    let questionImage: String?
    let passageImage: String?
    let aImage: String?
    let bImage: String?
    let cImage: String?
    let dImage: String?
    let eImage: String?
    let explanationImage: String?
    let passageVideo: String?
    let passageBook: String?

    enum CodingKeys: String, CodingKey {
        case question
        case passage
        case a
        case b
        case c
        case d
        case e
        case numberOfAnswer = "number_of_answer"
        case answer
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
        case passageVideo = "passage_video"
        case passageBook = "passage_book"
    }
}
