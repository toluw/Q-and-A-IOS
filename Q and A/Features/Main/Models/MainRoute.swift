//
//  MainRoute.swift
//  Q and A
//
//  Created by GIGL-PC on 26/03/2026.
//

import Foundation

enum MainRoute: Hashable{
    
    case mainCommunityScreen
    case forgotPasswordScreen
    case confirmOtpScreen(otp: String, email: String)
    case changePassword(email: String)
    case parentCatScreen(title: String, cbcId: String, level: String, isMock: String)
    case examSubCatScreen
    case examCatScreen
    case mockDescriptionScreen
    case examDescriptionScreen
    case cbtPaymentScreen
    case examPracticeScreen
    case cbtCartScreen
    case examLoaderScreen
    case paystackPaymentScreen(authorizationUrl: String, accessCode: String, reference: String)
    case examSceen
    case resultScreen(examResultData: ExamResultData)
    case fanQuizResultScreen(examId: String?, examResultData: ExamResultData?)
    case multipleResultScreen
    case mockExamResultScreen(mockId: String, mockExamResult: MockExamResult?)
    case passageScreen(passage: String, passageImage: String?, passageBook: String?, passageVideo: String?, pdfFile: String)
    case reviewExamScreen(examId: String)
    case aiCbtScreen(content: String)
    case reviewExplanationScreen(liveExam: LiveExam, isViewSolution: Bool, examId: String)
    
}
