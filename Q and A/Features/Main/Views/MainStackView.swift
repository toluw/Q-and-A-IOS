//
//  MainStackView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/01/2026.
//

import SwiftUI

struct MainStackView: View {
    
    @StateObject private var navVM = MainNavViewModel()
    @StateObject private var cbtViewModel = CbtViewModel()
    @StateObject private var paymentViewModel = PaymentViewModel()
    
    
    var body: some View {
        //  Text("Main Stack")
        NavigationStack(path: $navVM.path) {
                   
            MainScreen(navVm: navVM, cbtViewModel: cbtViewModel)
                .navigationDestination(for: MainRoute.self) { route in
                    destinationView(for: route)
             }
        }
        .environmentObject(navVM)
        .environmentObject(cbtViewModel)
        .onChange(of: navVM.path) { _, newPath in
            navVM.updateActiveRoute()
        }
    }
    
    
    @ViewBuilder
    private func destinationView(for route: MainRoute) -> some View{
        switch route{
        
        case .mainCommunityScreen : MainCommunityScreen()
            
            
        case .forgotPasswordScreen: ForgotPasswordScreen(navVm: navVM)
        
        case .confirmOtpScreen(otp: let otp, email: let email): ConfirmOtpScreen(otp: otp,email:email, navVm: navVM)
           
        case .changePassword(email: let email): ChangePasswordScreen(email: email, navVm: navVM)
        case .parentCatScreen(title: let title, cbcId: let cbcId, level: let level, isMock: let isMock):
            ParentCatScreen(title: title, cbcId: cbcId, level: level, isMock: isMock, navVm: navVM, cbtViewModel: cbtViewModel)
        case .examSubCatScreen:
             ExamSubCatScreen(navVm: navVM, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
        case .examCatScreen:
             ExamCatScreen(navVm: navVM, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
        case .mockDescriptionScreen:
             MockDescriptionScreen()
        case .examDescriptionScreen:
             ExamDescriptionScreen(navVm: navVM, cbtViewModel: cbtViewModel)
        case .cbtPaymentScreen:
            CbtPaymentScreen(navVm: navVM, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
        case .examPracticeScreen:
            ExamPracticeScreen(navVm: navVM, cbtViewModel: cbtViewModel)
        case .cbtCartScreen:
            CbtCartScreen(navVm: navVM, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
        case .paystackPaymentScreen(authorizationUrl: let authorizationUrl, accessCode: let accessCode, reference: let reference):
            PaystackPaymentScreen(authorizationUrl: authorizationUrl, reference: reference, paymentViewModel: paymentViewModel, navVm: navVM)
        case .examLoaderScreen:
            ExamLoaderScreen(navVm: navVM)
        case .examSceen:
            ExamScreen(navVm: navVM, cbtViewModel: cbtViewModel)
        case .resultScreen(examResultData: let examResultData):
            ResultScreen(navVm: navVM, cbtViewModel: cbtViewModel, examResultData: examResultData)
        case .fanQuizResultScreen(examId: let examId, examResultData: let examResultData):
            FanQuizResultScreen(navVm: navVM, cbtViewModel: cbtViewModel, examId: examId, examResultData: examResultData)
        case .multipleResultScreen:
            MultipleResultScreen(navVm: navVM, cbtViewModel: cbtViewModel)
        case .mockExamResultScreen(mockId: let mockId, mockExamResult: let mockExamResult):
            MockExamResultScreen(navVm: navVM, cbtViewModel: cbtViewModel, mockId: mockId, mockExamResult: mockExamResult)
        case .passageScreen(passage: let passage, passageImage: let passageImage, passageBook: let passageBook, passageVideo: let passageVideo, pdfFile: let pdfFile):
            PassageScreen(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile, navVm: navVM)
        case .reviewExamScreen(examId: let examId):
            ReviewExamScreen(navVm: navVM, cbtViewModel: cbtViewModel, examId: examId)
        case .aiCbtScreen(content: let content):
            AiCbtScreen(content: content)
        case .reviewExplanationScreen(liveExam: let liveExam, isViewSolution: let isViewSolution, examId: let examId):
            ReviewExplanationScreen(liveExam: liveExam, isViewSolution: isViewSolution, examId: examId, navVm: navVM)
        case .youtubePlayerScreen(videoURLString: let videoURLString):
            YoutubePlayerScreen(videoURLString: videoURLString)
        case .pdfReaderScreen(fileUrl: let fileUrl):
            PdfReaderScreen(fileUrl: fileUrl)
        case .pdfLoaderScreen(remoteURL: let remoteURL):
            PdfLoaderScreen(remoteURL: remoteURL, navVm: navVM)
        case .studyNoteScreen(title: let title, passage: let passage, passageImage: let passageImage, passageBook: let passageBook, passageVideo: let passageVideo):
            StudyNoteScreen(title: title, passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, navVm: navVM)
        case .cbtPostScreen(examId: let examId, liveExam: let liveExam):
            CbtPostScreen(navVm: navVM, examId: examId, liveExam: liveExam)
        }
    }
    
}

#Preview {
    MainStackView()
}
