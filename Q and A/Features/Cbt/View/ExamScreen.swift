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
                        
                    }, gotTo: {
                        
                        if(authorizeUser()){
                            viewModel.state.showGoToBottomSheet = true
                        }
                        
                    }, close: {
                        
                    }, readMorePassage: {
                        
                    }, onMultiSelect: {ans in
                        
                        cbtViewModel.multiSelect(ans: ans)
                        
                    }, onMultiDeselect: {ans in
                        
                        cbtViewModel.multiDeselect(ans: ans)
                        
                    }, onAnswerSelected: {ans in
                        cbtViewModel.answerQuestion(ans: ans)
                    }, timeDisplayText: $timeDisplayText)
                .id(liveExamBinding.id)
                    .transition(cbtViewModel.transition)
                
            }
           
           
            
            
           
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
                          
                       }
                       
                   )
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
    
    
    private func submit(isTimeOut: Bool = false){
        
        let score = cbtViewModel.liveExamList.getExamScore()
        
        let selectExam = cbtViewModel.examSelectList[cbtViewModel.examIndex]
        
        let timeDurationSecs = cbtViewModel.examDuration - cbtViewModel.remainingTime
        
        let endTime = if(cbtViewModel.parentCategoriesData?.catData?.isMock == true){
            cbtViewModel.parentCategoriesData?.catData?.endTime ?? ""
        }else{
            selectExam.endTime
        }
        
        let examResult = ExamResult(item: selectExam.item, examId: selectExam.exam.examId, numQuestions: cbtViewModel.liveExamList.count, shouldShuffle:  selectExam.shouldShuffle, category: selectExam.category, examTime: selectExam.disableReview ? selectExam.exam.duration :  selectExam.getExamTime(), score: score, createAt: getCurrentTime(), disableReview: selectExam.disableReview, timeDuration: Int(timeDurationSecs.rounded()), endTime: endTime)
        
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
        
    }
    
    private func moveToResult(){
        
    }
    
    private func moveToNextExam(){
        cbtViewModel.examIndex += 1
        cbtViewModel.finishExam(hasNext: true)
        navVm.navigateAndPop(route: .examDescriptionScreen, pop: 1)
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
