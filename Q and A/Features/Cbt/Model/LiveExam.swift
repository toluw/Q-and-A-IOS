//
//  LiveExam.swift
//  Q and A
//
//  Created by GIGL-PC on 03/05/2026.
//

import Foundation

struct LiveExam: Codable, Equatable, Identifiable {
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
    var questionId: String
    let questionImage: String?
    let passageImage: String?
    let aImage: String?
    let bImage: String?
    let cImage: String?
    let dImage: String?
    let eImage: String?
    let explanationImage: String?
    var solution: [String] = []
    let passageVideo: String?
    let passageBook: String?
    
    var id: String {
           questionId
    }

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
        case solution
        case passageVideo = "passage_video"
        case passageBook = "passage_book"
    }
    
    static let preview = LiveExam(question: "What is a Syrogyra?", passage: "Insruction: Answer all questions by giving the most accurate answers. Do not include your name. Be fast and accurate. Ensure you spend quality time practicing. You will not be allowed to retake the exam. Use HB pencil only. Bring your A game. Dont be distracted. Put in your best work.", a: "Idolatary", b: "Fun Fare", c: "Genital Enlargement", d: "Succide", e: "Perimeter Fencing", numberOfAnswer: 2, answer: "a", explanation: "There are two types of Kidney. Take your time to study them in details", questionId: "Youtube is your best friend. Subscribe to youtube today. Chhers", questionImage: nil, passageImage: nil, aImage: nil, bImage: nil, cImage: nil, dImage: nil, eImage: nil, explanationImage: nil, solution: ["c"], passageVideo: nil, passageBook: nil)
}


extension [LiveExam]{
    
    func goToQuestionList() -> [GoToQuestion]{
        
        var goToQuestionList : [GoToQuestion] = []
        
        for index in self.indices {
            let goToQuestion = GoToQuestion(questionIndex: index,hasAttempted: !self[index].solution.isEmpty)
            goToQuestionList.append(goToQuestion)
        }
        
        return goToQuestionList
        
    }
    
    func getExamScore() -> Double{
        
        guard !self.isEmpty else {
               return 0
           }
           
           var point = 0
           
           for liveExam in self {
               
               let answer = liveExam.answer.convertCommaDelimitedStringToList()
               let solution = liveExam.solution
               
               if liveExam.numberOfAnswer > 1 &&
                   liveExam.numberOfAnswer != solution.count {
                   continue
               }
               
               if answer.sorted() == solution.sorted() {
                   point += 1
               }
           }
           
           return (Double(point) / Double(self.count)) * 100
    }
    
}
