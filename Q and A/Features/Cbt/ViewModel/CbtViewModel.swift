//
//  CbtViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 14/04/2026.
//

import Foundation
import SwiftUI


@MainActor
class CbtViewModel: ObservableObject{
    
    
    var parentCategoriesData: DataModel? = nil
    var mockCatData: DataModel? = nil
    var examSelectList: [ExamSelect] = []
    var examIndex = 0
    var examResultDataList: [ExamResultData] = []
    var multipleExams: [MultipleExam] = []
    var indexList: [Int] = []
    var selectedExamPay: [ExamPay] = []
    var liveExamList: [LiveExam] = []
    @Published var questionIndex: Int = 0
    @Published var liveExam: LiveExam? = nil
    @Published var transition: AnyTransition = .identity
    
    var reviewExamList: [LiveExam] = []
    @Published var reviewIndex: Int = 0
    @Published var reviewExam: LiveExam? = nil
   
    var examDuration: TimeInterval = 0
    var remainingTime: TimeInterval = 0
    var endTime: Date? = nil
    
    @Published var timerState: TimerResult = .tick
    
    private var timer: Timer?
    
    
    private let cbtService: CbtServiceProtocol
   
      
      init(cbtService: CbtServiceProtocol = CbtService()) {
          self.cbtService = cbtService
          
      }
    
    
    
    func startExam() {
        guard endTime == nil else {
            
            timerState = .tick
            return
            
        }
          endTime = Date().addingTimeInterval(examDuration)
          startTimer()
      }
    
    
    
    private func startTimer() {
        guard let end = endTime else { return }
        let remaining = end.timeIntervalSinceNow
        initTimer(remaining: remaining)
        
    }
    
    
    
    
    func initTimer(remaining: TimeInterval) {
           timer?.invalidate()
           
           guard remaining > 0 else {
               timerState = .ended
               return
           }
           
           timerState = .tick
           
           timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
               Task { @MainActor [weak self] in
                   self?.onTimerTick()
               }
           }
       }
    
    func postResult(examResultBody: ExamResultBody){
        
        Task{
            do{
              
                _ = try await cbtService.postResult(examResultBody: examResultBody)
                
                
                
                
            } catch {
                
                showErrorMessage(message: "Could not save your result - \(error.localizedDescription)", actionTitle: "Retry", showCancel: true, action: {
                    self.postResult(examResultBody: examResultBody)
                })
            }
        }
        
    }
    
    func postUnfisnishedResult(unfinishedResultBody: UnfinishedResultBody){
        Task{
            do{
              
                _ = try await cbtService.postUnfinishedResult(unfinishedResultBody: unfinishedResultBody)
                
                
                
                
            } catch {
                
                showErrorMessage(message: "Could not save exam data - \(error.localizedDescription)", actionTitle: "Retry", showCancel: true, action: {
                    self.postUnfisnishedResult(unfinishedResultBody: unfinishedResultBody)
                })
            }
        }
    }
    
    
    private func onTimerTick() {
           guard let end = endTime else { return }
           let remaining = end.timeIntervalSinceNow
           
           if remaining <= 0 {
               timerState = .ended
               timer?.invalidate()
           } else {
               timerState = .tick
           }
    }
    
    
    deinit {
          timer?.invalidate()
      }
    
    func finishExam(hasNext: Bool = false) {
          timer?.invalidate()
          timer = nil
          
          if hasNext {
              examDuration = remainingTime
          } else {
              examDuration = 0
          }
          remainingTime = 0
          endTime = nil
      }
    
    
    func initIndexList() {
        indexList = Array(repeating: 0, count: multipleExams.count)
    }
    
    
    
    
    func getTotalExamTime() -> Int {
        var totalTime: Int = 0
        
        examSelectList.forEach {
            totalTime += $0.getExamTime() * 60
        }
        
        return totalTime
    }
    
    func nextQuestion(){
        questionIndex += 1
        updateLiveExam(liveExamUpdateMode: .next)
    }
    
    func nextReview(){
        reviewIndex += 1
        updateReviewExam(liveExamUpdateMode: .next)
    }
    
    func goToQuestion(index: Int){
        questionIndex = index
        updateLiveExam(liveExamUpdateMode: .next)
    }
    
    func goToReview(index: Int){
        reviewIndex = index
        updateReviewExam(liveExamUpdateMode: .next)
    }
    
    func answerQuestion(ans: String){
        liveExamList[questionIndex].solution = [ans]
        updateLiveExam(liveExamUpdateMode: .normal)
    }
    
    func multiSelect(ans: String){
        liveExamList[questionIndex].solution.append(ans)
        updateLiveExam(liveExamUpdateMode: .normal)
    }
    
    func multiDeselect(ans: String){
        if let index =  liveExamList[questionIndex].solution.firstIndex(of: ans) {
            liveExamList[questionIndex].solution.remove(at: index)
        }
        
        updateLiveExam(liveExamUpdateMode: .normal)

    }
    
    func previousQuestion(){
        questionIndex -= 1
        updateLiveExam(liveExamUpdateMode: .previous)
    }
    
    func previousReview(){
        reviewIndex -= 1
        updateReviewExam(liveExamUpdateMode: .previous)
    }
    
    func updateReviewExam(liveExamUpdateMode: LiveExamUpdateMode){
        
        let reviewExamUpdate = reviewExamList[reviewIndex]
        
        switch liveExamUpdateMode {
        
        case .previous:
            transition = .asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            )
            
            withAnimation(.easeInOut) {
                reviewExam = reviewExamUpdate
            }
            
        case .next:
            
            transition = .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            )
            
            withAnimation(.easeInOut) {
                reviewExam = reviewExamUpdate
            }
            
        case .normal:
            transition = .identity
            
            reviewExam = reviewExamUpdate
            
            
        }
        
    }
    
    func updateLiveExam(liveExamUpdateMode: LiveExamUpdateMode) {
        
        let liveExamUpdate = liveExamList[questionIndex]
        
        switch liveExamUpdateMode {
            
        case .next:
            transition = .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            )
            
            withAnimation(.easeInOut) {
                liveExam = liveExamUpdate
            }
            
        case .previous:
            transition = .asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            )
            
            withAnimation(.easeInOut) {
                liveExam = liveExamUpdate
            }
            
        case .normal:
            transition = .identity
            
            liveExam = liveExamUpdate
        }
    }
    
    
    func initLiveExam(examQuestions: [ExamQuestion], examSelect: ExamSelect) {
        
        let list: [ExamQuestion]
        
        if examSelect.shouldShuffle {
            list = examQuestions.shuffled()
        } else {
            list = examQuestions
        }
        
        let examList = Array(list.prefix(examSelect.numQuestions))
        
        liveExamList = examList.map {
            LiveExam(
                question: $0.question.trimmingCharacters(in: .whitespacesAndNewlines),
                passage: $0.passage.trimmingCharacters(in: .whitespacesAndNewlines),
                a: $0.a.trimmingCharacters(in: .whitespacesAndNewlines),
                b: $0.b.trimmingCharacters(in: .whitespacesAndNewlines),
                c: $0.c.trimmingCharacters(in: .whitespacesAndNewlines),
                d: $0.d.trimmingCharacters(in: .whitespacesAndNewlines),
                e: $0.e.trimmingCharacters(in: .whitespacesAndNewlines),
                numberOfAnswer: $0.numberOfAnswer,
                answer: $0.answer.trimmingCharacters(in: .whitespacesAndNewlines),
                explanation: $0.explanation.trimmingCharacters(in: .whitespacesAndNewlines),
                questionId: $0.questionId.trimmingCharacters(in: .whitespacesAndNewlines),
                questionImage: $0.questionImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                passageImage: $0.passageImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                aImage: $0.aImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                bImage: $0.bImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                cImage: $0.cImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                dImage: $0.dImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                eImage: $0.eImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                explanationImage: $0.explanationImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                solution: [],
                passageVideo: $0.passageVideo?.trimmingCharacters(in: .whitespacesAndNewlines),
                passageBook: $0.passageBook?.trimmingCharacters(in: .whitespacesAndNewlines)
            )
        }
    }
    
    
    func getExamPayTotalPrice() -> Int{
        var totalPrice = 0
        
        for examPay in selectedExamPay{
            
            totalPrice += examPay.exam.price
            
        }
        
        return totalPrice
        
    }
    
    
    func getPaystackMetadData() -> PaystackMetaData{
        
        var paymentDataList: [PaymentData] = []
        
        for examPay in selectedExamPay{
            
            let paymentData = PaymentData(title: examPay.exam.title, paymentType: "cbt", category: "exam_id: \(examPay.exam.examId)")
            
            paymentDataList.append(paymentData)
            
        }
        
        
        return PaystackMetaData(custiomFields: paymentDataList)
        
        
    }
    
    
    func getTransactionBody(buyerEmail: String, reference: String) -> PostTransactionBody{
        
        let transactions: [Transaction] = selectedExamPay.map{
            
            Transaction(exam_id: $0.exam.examId, seller_email: $0.exam.sellerEmail, price: $0.exam.price)
            
        }
        
        return PostTransactionBody(buyer_email: buyerEmail, reference: reference, exams: transactions)
    }
    
    
    func getMultipleExamBody(
        examSelectList: [ExamSelect],
        buyerEmail: String
    ) -> MultipleExamsBody {

        let data = examSelectList.map {
            MultipleExamsBody.ExamBody(
                examId: $0.exam.examId,
                item: $0.item
            )
        }

        return MultipleExamsBody(
            buyerEmail: buyerEmail,
            exams: data
        )
    }
    
    func initMultipleExams(
        multipleExamQuestions: [MultipleExamsResponse.MultipleExamData],
        examSelectList: [ExamSelect]
    ) {
        multipleExams = []

        for questions in multipleExamQuestions {

            let examSelect = examSelectList.first {
                $0.exam.examId == questions.examId
            }

            if let select = examSelect {

                let list = select.shouldShuffle
                    ? questions.examData.shuffled()
                    : questions.examData

                let examList = Array(list.prefix(select.numQuestions))

                let liveExamList = examList.map {
                    LiveExam(
                        question: $0.question.trimmingCharacters(in: .whitespacesAndNewlines),
                        passage: $0.passage.trimmingCharacters(in: .whitespacesAndNewlines),
                        a: $0.a.trimmingCharacters(in: .whitespacesAndNewlines),
                        b: $0.b.trimmingCharacters(in: .whitespacesAndNewlines),
                        c: $0.c.trimmingCharacters(in: .whitespacesAndNewlines),
                        d: $0.d.trimmingCharacters(in: .whitespacesAndNewlines),
                        e: $0.e.trimmingCharacters(in: .whitespacesAndNewlines),
                        numberOfAnswer: $0.numberOfAnswer,
                        answer: $0.answer.trimmingCharacters(in: .whitespacesAndNewlines),
                        explanation: $0.explanation.trimmingCharacters(in: .whitespacesAndNewlines),
                        questionId: $0.questionId.trimmingCharacters(in: .whitespacesAndNewlines),
                        questionImage: $0.questionImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        passageImage: $0.passageImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        aImage: $0.aImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        bImage: $0.bImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        cImage: $0.cImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        dImage: $0.dImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        eImage: $0.eImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        explanationImage: $0.explanationImage?.trimmingCharacters(in: .whitespacesAndNewlines),
                        solution: [], // default since not provided
                        passageVideo: $0.passageVideo?.trimmingCharacters(in: .whitespacesAndNewlines),
                        passageBook: $0.passageBook?.trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                }

                let multipleExam = MultipleExam(
                    examId: select.exam.examId,
                    item: select.item,
                    liveExamList: liveExamList
                )

                multipleExams.append(multipleExam)
            }
        }
    }
    
    
    
}
