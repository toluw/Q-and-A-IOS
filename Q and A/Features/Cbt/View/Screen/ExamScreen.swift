//
//  ExamScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 30/05/2026.
//

import SwiftUI

struct ExamScreen: View {
    
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @StateObject var viewModel: ExamViewModel = .init()
    @State private var timeDisplayText: String = "--:--"
    
    var body: some View {
        ZStack{
            
            if let liveExamBinding = $cbtViewModel.liveExam.unwrap() {
                
                ExamView(questionCount: cbtViewModel.liveExamList.count, questionIndex: $cbtViewModel.questionIndex, liveExam: liveExamBinding,examState: $viewModel.state,
                    next: {
                    
                    if(authorizeUser()){
                        cbtViewModel.nextQuestion()
                        viewModel.reInitState()
                    }
                   
                    
                    }, previous: {
                        
                        if(authorizeUser()){
                            cbtViewModel.previousQuestion()
                            viewModel.reInitState()
                        }
                        
                       
                        
                    }, submit: {
                        
                        if(authorizeUser()){
                            viewModel.state.showSubmitDialog = true
                        }
                        
                    }, gotTo: {
                        
                        if(authorizeUser()){
                            viewModel.state.showGoToBottomSheet = true
                        }
                        
                    }, close: {
                        showErrorMessage(message: "Are you sure you want to leave this assessment?", actionTitle: "Exit", showCancel: true, action: {
                            exit()
                        })
                    }, readMorePassage: {
                        readMorePassage()
                    }, onMultiSelect: {ans in
                        
                        cbtViewModel.multiSelect(ans: ans)
                        
                    }, onMultiDeselect: {ans in
                        
                        cbtViewModel.multiDeselect(ans: ans)
                        
                    }, onAnswerSelected: {ans in
                        cbtViewModel.answerQuestion(ans: ans)
                    }, timeDisplayText: $timeDisplayText,
                       onCalculatorClicked: {
                    viewModel.state.showCalculator = true
                    })
                .id(liveExamBinding.id)
                    .transition(cbtViewModel.transition)
                
            }
           
           
            if(viewModel.state.showSubmitDialog){
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.state.showSubmitDialog = false
                    }

                SubmitTestDialog(
                    onReview: {
                        viewModel.state.showSubmitDialog = false
                        
                    },
                    onSubmit: {
                        viewModel.state.showSubmitDialog = false
                        submit()
                    }
                )
                .transition(.scale)
            }
            
           
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut, value: viewModel.state.showSubmitDialog)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $viewModel.state.showLogin){
                   LoginScreen(
                       onDismiss: {
                           viewModel.state.showLogin = false
                       }, onForgotpassword: {
                           viewModel.state.showLogin = false
                           navVm.navigate(route: .forgotPasswordScreen)
                       }, onLoginSuccess: {userProfile in
                           viewModel.state.showLogin = false
                           showSuccessMessage(message: "Thanks \(userProfile.name)! You are now logged in", actionTitle: "Continue", showCancel: false){
                               navVm.pop()
                           }
                          
                       },
                       navVM: navVm
                       
                   )
               }
            .sheet(isPresented: $viewModel.state.showCalculator){
                CalculatorView(onDismiss: {
                    viewModel.state.showCalculator = false
                })
            }
            .sheet(isPresented: $viewModel.state.showGoToBottomSheet){
                GoToQuestionBottomSheetView(fullQuestionList: cbtViewModel.liveExamList.goToQuestionList(), onQuestionSelected: {data in
                    
                    cbtViewModel.goToQuestion(index: data.questionIndex)
                    
                    viewModel.reInitState()
                    
                    viewModel.state.showGoToBottomSheet = false
                    
                })
            }.onAppear{
                cbtViewModel.startExam()
            } .onReceive(cbtViewModel.$timerState) { state in
                switch state {
                case .tick:
                    tickTimer()
                case .ended:
                    if cbtViewModel.endTime != nil {
                        timeOut()
                    }
                }
            }
        
    }
    
    
    private func viewPassage(
          passage: String,
          passageImage: String?,
          passageBook: String?,
          passageVideo: String?,
          pdfFile: String
    ){
        navVm.navigate(route: .passageScreen(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile))
    }
    
    
    private func viewPdf(pdfFile: String, directDownloadLink: String){
        if let remoteLink = URL(string: directDownloadLink){
            openPDF(remoteURL: remoteLink, navVM: navVm)
        }
    }
    
    
    
    private func readMorePassage(){
       
        
          let passage = cbtViewModel.liveExamList[cbtViewModel.questionIndex].passage
               let passageImage = cbtViewModel.liveExamList[cbtViewModel.questionIndex].passageImage
               let passageVideo = cbtViewModel.liveExamList[cbtViewModel.questionIndex].passageVideo
               let passageBook = cbtViewModel.liveExamList[cbtViewModel.questionIndex].passageBook
               let pdfFile = "\(passageBook?.extractGoogleDriveFileId() ?? "").pdf"
               let directDownloadLink = convertGoogleDriveLinkToDirect(passageBook)
        
        if(passageImage?.isEmpty ?? true && passage.count <= PASSAGE_NUM
                  && passageVideo?.isValidYouTubeUrl() != true && directDownloadLink == nil
                  ){
                  return
              }

        if(directDownloadLink != nil && passageVideo?.isValidYouTubeUrl() != true){
            viewPdf(pdfFile: pdfFile, directDownloadLink: directDownloadLink!)
        }
        else if(directDownloadLink != nil && passageVideo?.isValidYouTubeUrl() == true){
           viewPassage(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile)
        }
        else if(passageImage?.isEmpty == false){
            viewPassage(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile)
        }
        else if (passage.count > FULL_PASSAGE_NUM){
            viewPassage(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile)
        }else{
            
            viewModel.state.showFullPassage = true
            
        }
        
        
        
        
    }
    
   
    
    
    private func timeOut() {
        timeDisplayText = "--:--"
        if(UserSettings.isLoggedIn){
            showSuccessMessage(message: "You have run out of time, your exam has been automatically submitted.", actionTitle: "View Result", showCancel: false, action: {
                submit(isTimeOut: true)
            })
        }else{
            showSuccessMessage(message: "You have run out of time. Kindly Login to Proceed", actionTitle: "Login", action: {
                
                viewModel.state.showLogin = true
            })
        }
        
    }
    
    private func exit(){
       
        let selectExam = cbtViewModel.examSelectList[cbtViewModel.examIndex]
        
        let timeDurationSecs = cbtViewModel.examDuration - cbtViewModel.remainingTime
        
        let examResult = ExamResult(item: selectExam.item, examId: selectExam.exam.examId, numQuestions: cbtViewModel.liveExamList.count, shouldShuffle:  selectExam.shouldShuffle, category: selectExam.category, examTime: selectExam.disableReview ? selectExam.exam.duration :  selectExam.getExamTime(), score: 0.0, createAt: getCurrentTime(), disableReview: selectExam.disableReview, timeDuration: Int(timeDurationSecs.rounded()), endTime: selectExam.endTime)
        
        let buyerEmail = UserSettings.email
        
        let unfinishedResultBody = UnfinishedResultBody(
                  item: examResult.item,
                  numQuestions: examResult.numQuestions,
                  examId: Int(examResult.examId) ?? 0,
                  shouldShuffle: examResult.shouldShuffle,
                  category: examResult.category,
                  image: examResult.image,
                  examTime: examResult.examTime,
                  score: examResult.score,
                  buyerEmail: buyerEmail ?? "",
                  isCompleted: false,
                  disableReview: examResult.disableReview,
                  timeDuration: Int(timeDurationSecs.rounded()),
                  endTime: examResult.endTime
              )
        
        cbtViewModel.postUnfisnishedResult(unfinishedResultBody: unfinishedResultBody)
        
        navVm.pop()
        
    }
    
    
    private func submit(isTimeOut: Bool = false){
        
        let score = cbtViewModel.liveExamList.getExamScore()
        
        print("app_score:\(score)")
        
        let selectExam = cbtViewModel.examSelectList[cbtViewModel.examIndex]
        
        let timeDurationSecs = cbtViewModel.examDuration - cbtViewModel.remainingTime
        
        let endTime = if(cbtViewModel.parentCategoriesData?.catData?.isMock == true){
            cbtViewModel.parentCategoriesData?.catData?.endTime ?? ""
        }else{
            selectExam.endTime
        }
        
        let examResult = ExamResult(item: selectExam.item, examId: selectExam.exam.examId, numQuestions: cbtViewModel.liveExamList.count, shouldShuffle:  selectExam.shouldShuffle, category: selectExam.category,
                                    image: selectExam.image,examTime: selectExam.disableReview ? selectExam.exam.duration :  selectExam.getExamTime(), score: score, createAt: getCurrentTime(), disableReview: selectExam.disableReview, timeDuration: Int(timeDurationSecs.rounded()), endTime: endTime)
        
        let examResultData = ExamResultData(examResult: examResult, liveExamList: cbtViewModel.liveExamList)
        
        if(selectExam.disableReview){
            cbtViewModel.examResultDataList = [examResultData]
        }else{
            cbtViewModel.examResultDataList.append(examResultData)
        }
        
        uploadResult(examResultData: examResultData)
        
        if(cbtViewModel.examIndex < (cbtViewModel.examSelectList.count - 1)){
            if(isTimeOut){
                moveToResult()
            }else{
                moveToNextExam()
            }

        }else{
            
            moveToResult()
            
        }
        
        
        
    }
    
    
    private func uploadResult(examResultData: ExamResultData){
        
        let examResult: [ExamResultBodyData] = examResultData.liveExamList.map{it in
            ExamResultBodyData(question: it.question, numberOfAnswer: it.numberOfAnswer, answer: it.answer, passage: it.passage, a: it.a, b: it.b, c: it.c, d: it.d, e: it.e, explanation: it.explanation, questionId: Int(it.questionId) ?? 0, questionImage: it.questionImage, passageImage: it.passageImage, aImage: it.aImage, bImage: it.bImage, cImage: it.cImage, dImage: it.dImage, eImage: it.eImage, explanationImage: it.explanationImage, solution: it.solution.isEmpty ? "" : it.solution.toCommaDelimitedString(), passageVideo: it.passageVideo, passageBook: it.passageBook)
        }
        
        let buyerEmail = UserSettings.email
        
        let examResultBody = ExamResultBody(item: examResultData.examResult.item, numQuestions: examResultData.examResult.numQuestions, examId: Int(examResultData.examResult.examId) ?? 0, shouldShuffle: examResultData.examResult.shouldShuffle, category: examResultData.examResult.category, image: examResultData.examResult.image, examTime: examResultData.examResult.examTime, score: examResultData.examResult.score, buyerEmail: buyerEmail ?? "", isCompleted: true, resultData: examResult, disableReview: examResultData.examResult.disableReview, timeDuration: examResultData.examResult.timeDuration, endTime: examResultData.examResult.endTime, cbtId: cbtViewModel.parentCategoriesData?.catData?.cbtId ?? "0")
        
        cbtViewModel.postResult(examResultBody: examResultBody)
    }
    
    private func moveToResult(){
        if(cbtViewModel.parentCategoriesData?.catData?.isMock == true){
           
            if let cbtId = cbtViewModel.parentCategoriesData?.catData?.cbtId{
                
                let examResultList = cbtViewModel.examResultDataList.map{it in
                    it.examResult
                }
                
                let mockExamResult = MockExamResult(examResultList: examResultList, title: cbtViewModel.parentCategoriesData?.item ?? "")
                
                cbtViewModel.finishExam()
                
                navVm.replaceTop(route: .mockExamResultScreen(mockId: cbtId, mockExamResult: mockExamResult))
                
            }
            
        }else{
           
            if(cbtViewModel.examResultDataList.count > 1){
                
                cbtViewModel.finishExam()
                navVm.replaceTop(route: .multipleResultScreen)
                
            }else{
              
                let data = cbtViewModel.examResultDataList[0]
                if(data.examResult.disableReview){
                    cbtViewModel.finishExam()
                    navVm.replaceTop(route: .fanQuizResultScreen(examId: nil, examResultData: data))
                }else{
                    cbtViewModel.finishExam()
                    navVm.replaceTop(route: .resultScreen(examResultData: data))
                }
                
            }
            
        }
    }
    
    private func moveToNextExam(){
        cbtViewModel.examIndex += 1
        cbtViewModel.finishExam(hasNext: true)
        navVm.replaceTop(route: .examDescriptionScreen)
    }
    
    private func tickTimer(){
        guard let end = cbtViewModel.endTime else { return }
               let remaining = end.timeIntervalSinceNow
               
               if remaining <= 0 {
                   timeOut()
               } else {
                   cbtViewModel.remainingTime = remaining
                   timeDisplayText = remaining.toTimeFormat()
               }
        
    }
    
    
    private func authorizeUser() -> Bool{
        if(cbtViewModel.questionIndex >= 2 && !UserSettings.isLoggedIn){
            viewModel.state.showLogin = true
            return false
        }
        
        return true
    }
    
}



#Preview {
    ExamScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
