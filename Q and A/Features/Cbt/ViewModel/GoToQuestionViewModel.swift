//
//  GoToQuestionViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 05/06/2026.
//

import Foundation

@MainActor
class GoToQuestionViewModel: ObservableObject{
    
    @Published var state: GoToQuestionState = .init()
    
    
    func selectQuestion(question: GoToQuestion){
        
        if(state.selectedQuestion != nil){
            state.questions[state.selectedQuestion!.questionIndex].isSeleceted = false
        }
        
        state.questions[question.questionIndex].isSeleceted = true
        
    }
    
    
    
    func initQuestions(fullQuestions: [GoToQuestion]){
        state.questions = Array(fullQuestions.prefix(13))
        state.showSeeAllButton = fullQuestions.count > 13
    }
    
    func seeAll(fullQuestions: [GoToQuestion]) {
        guard state.questions.count < fullQuestions.count else { return }
          
        state.questions.append(contentsOf: fullQuestions[state.questions.count...])
        
        state.showSeeAllButton = false
    }
    
}
