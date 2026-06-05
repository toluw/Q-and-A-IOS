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
                    })
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
