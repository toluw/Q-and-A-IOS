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
                    
                    cbtViewModel.nextQuestion()
                    viewModel.reInitState()
                    
                    }, previous: {
                        
                        cbtViewModel.previousQuestion()
                        viewModel.reInitState()
                        
                    }, submit: {
                        
                    }, gotTo: {
                        
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
            
    }
}

#Preview {
    ExamScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
