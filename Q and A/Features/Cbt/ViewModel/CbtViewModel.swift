//
//  CbtViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 14/04/2026.
//

import Foundation


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
    
    
    
    func initIndexList() {
        indexList = Array(repeating: 0, count: multipleExams.count)
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
                        question: $0.question,
                        passage: $0.passage,
                        a: $0.a,
                        b: $0.b,
                        c: $0.c,
                        d: $0.d,
                        e: $0.e,
                        numberOfAnswer: $0.numberOfAnswer,
                        answer: $0.answer,
                        explanation: $0.explanation,
                        questionId: $0.questionId,
                        questionImage: $0.questionImage,
                        passageImage: $0.passageImage,
                        aImage: $0.aImage,
                        bImage: $0.bImage,
                        cImage: $0.cImage,
                        dImage: $0.dImage,
                        eImage: $0.eImage,
                        explanationImage: $0.explanationImage,
                        solution: [], // default since not provided
                        passageVideo: $0.passageVideo,
                        passageBook: $0.passageBook
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
