//
//  GoToReviewViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 23/06/2026.
//

import Foundation

@MainActor
class GoToReviewViewModel: ObservableObject{
    
    @Published var state: GoToReviewState = .init()
    
    
    func selectQuestion(question: GoToReview){
        
        if(state.selectedQuestion != nil){
            state.questions[state.selectedQuestion!.questionIndex].isSeleceted = false
        }
        
        state.questions[question.questionIndex].isSeleceted = true
        
    }
    
    
    
    func initQuestions(fullQuestions: [GoToReview]){
        state.questions = Array(fullQuestions.prefix(25))
        state.showSeeAllButton = fullQuestions.count > 25
    }
    
    func seeAll(fullQuestions: [GoToReview]) {
        guard state.questions.count < fullQuestions.count else { return }
          
        state.questions.append(contentsOf: fullQuestions[state.questions.count...])
        
        state.showSeeAllButton = false
    }
    
    
    
    
}
