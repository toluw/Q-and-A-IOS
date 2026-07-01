//
//  LiveExam.swift
//  Q and A
//
//  Created by GIGL-PC on 03/05/2026.
//

import Foundation

struct LiveExam: Codable, Equatable, Identifiable, Hashable {
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
    
    static let preview = LiveExam(question: "What is a Syrogyra?", passage: "Insruction: Answer all questions by giving the most accurate answers. Do not include your name. Be fast and accurate. Ensure you spend quality time practicing. You will not be allowed to retake the exam. Use HB pencil only. Bring your A game. Dont be distracted. Put in your best work.", a: "Idolatary", b: "Fun Fare", c: "Genital Enlargement", d: "Succide", e: "Perimeter Fencing", numberOfAnswer: 2, answer: "c,b", explanation: "There are two types of Kidney. Take your time to study them in details", questionId: "Youtube is your best friend. Subscribe to youtube today. Chhers", questionImage: nil, passageImage: nil, aImage: nil, bImage: nil, cImage: nil, dImage: nil, eImage: nil, explanationImage: nil, solution: ["a","b","c"], passageVideo: nil, passageBook: nil)
    
    func getAnswer() -> String{
        
        if(answer.isEmpty){
            return ""
        }
        
        switch answer.convertCommaDelimitedStringToList()[0].lowercased() {
            
        case "a":
            return a

        case "b":
            return b

        case "c":
            return c

        case "d":
            return d

        case "e":
            return e

        default:
            return ""
        }
    }
    
    func getAnswerData() -> [AnswerData] {
         let dataList = answer.convertCommaDelimitedStringToList()
         var result: [AnswerData] = []

         for ans in dataList {
             switch ans.lowercased() {
             case "a":
                 result.append(
                     AnswerData(
                        answerChar: ans.uppercased(),
                        answerText: a,
                         image: aImage
                     )
                 )

             case "b":
                 result.append(
                     AnswerData(
                        answerChar: ans.uppercased(),
                        answerText: b,
                         image: bImage
                     )
                 )

             case "c":
                 result.append(
                     AnswerData(
                        answerChar: ans.uppercased(),
                        answerText: c,
                         image: cImage
                     )
                 )

             case "d":
                 result.append(
                     AnswerData(
                        answerChar: ans.uppercased(),
                        answerText: d,
                         image: dImage
                     )
                 )

             case "e":
                 result.append(
                     AnswerData(
                        answerChar: ans.uppercased(),
                        answerText: e,
                         image: eImage
                     )
                 )

             default:
                 break
             }
         }

         return result
     }
    
    func getExplanationStatus() -> ExplanationStatus {
        
        if(solution.isEmpty){
            return .viewSolution
        }
        
        if(numberOfAnswer > 1){
            
            if(solution.count < answer.convertCommaDelimitedStringToList().count){
                return .viewSolution
            }
            
            if(answer.convertCommaDelimitedStringToList().sorted() == solution.sorted()){
                return .showCorrectAnswer
            }else{
                return .showWrongAnswer
            }
            
        }else{
            if(solution[0].lowercased() == answer.convertCommaDelimitedStringToList()[0].lowercased()){
                return .showCorrectAnswer
            }else{
                return .showWrongAnswer
            }
        }
        
    }
    

    
    func getOption(ans: String)-> String{
        
        switch ans {
        case "a":
            return a

        case "b":
            return b

        case "c":
            return c

        case "d":
            return d

        case "e":
            return e

        default:
            return ""
        }
        
        
    }
    
    func getOptionImage(ans: String) -> String?{
        switch ans {
        case "a":
            return aImage

        case "b":
            return bImage

        case "c":
            return cImage

        case "d":
            return dImage

        case "e":
            return eImage

        default:
            return nil
        }
        
        
    }
    
    func getWrongAnswerStatus() -> [AnswerStatus] {
        
        let answerList = answer.convertCommaDelimitedStringToList()
        
        var data: [AnswerStatus] = []
        
        for sol in solution {
            if !answerList.contains(sol) {
                data.append(AnswerStatus(answer: sol, content: getOption(ans: sol), image: getOptionImage(ans: sol), isCorrect: false))
            }
        }
        
        for ans in answerList {
            data.append(AnswerStatus(answer: ans, content: getOption(ans: ans), image: getOptionImage(ans: ans), isCorrect: true))
        }
        
        return data
    }
    
    func getCorrectAnswerStatus() -> [AnswerStatus]{
        
        var data: [AnswerStatus] = []
        
        for sol in solution{
            data.append(AnswerStatus(answer: sol, content: getOption(ans: sol), image: getOptionImage(ans: sol), isCorrect: true))
        }
        
        return data
        
    }
    
    func getAnswerStatus() -> [AnswerStatus]{
        if (answer.lowercased() == solution.toCommaDelimitedString().lowercased()){
            return getCorrectAnswerStatus()
        }else{
            return getWrongAnswerStatus()
        }
    }
    
    func getAnswerImage() -> String?{
        
        if(answer.isEmpty){
            return nil
        }
        
        switch answer.convertCommaDelimitedStringToList()[0].lowercased() {
            
        case "a":
            return aImage

        case "b":
            return bImage

        case "c":
            return cImage

        case "d":
            return dImage

        case "e":
            return eImage

        default:
            return nil
        }
        
    }
    
    func getSolution() -> String{
        
        if(solution.isEmpty){
            return ""
        }
        
        switch solution[0].lowercased() {
        case "a":
            return a

        case "b":
            return b

        case "c":
            return c

        case "d":
            return d

        case "e":
            return e

        default:
            return ""
        
        }
        
    }
    
    func isExamCorrect() -> Bool {

           if solution.isEmpty {
               return false
           }

           if solution.sorted() != answer.convertCommaDelimitedStringToList().sorted() {
               return false
           }

           return true
    }
    
    func getSolutionImage() -> String? {
        if(solution.isEmpty){
            return nil
        }
        
        switch solution[0].lowercased() {
        case "a":
            return aImage

        case "b":
            return bImage

        case "c":
            return cImage

        case "d":
            return dImage

        case "e":
            return eImage

        default:
            return nil
        
        }
        
    }
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
    
    func goToReviewList() -> [GoToReview]{
        
        var goToReviewList: [GoToReview] = []
        
        for index in self.indices{
            let goToReview = GoToReview(questionIndex: index, isCorrect: self[index].isExamCorrect())
            
            goToReviewList.append(goToReview)
        }
        
        return goToReviewList
        
        
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
