//
//  PracticeScreenViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 30/06/2026.
//

import Foundation
import SwiftUI

@MainActor
class PracticeScreenViewModel: ObservableObject{
    
    var liveExamList: [LiveExam] = []
    @Published var questionIndex: Int = 0
    @Published var liveExam: LiveExam? = nil
    @Published var transition: AnyTransition = .identity
    @Published var state: ExamState = ExamState()
    
    
    
    
    func reInitState(){
        
        state = ExamState()
    }
    
    
    func initLiveExam(liveExams: [LiveExam]){
        if(liveExamList.isEmpty){
            liveExamList = liveExams
        }
        
    }
    
    func nextQuestion(){
        questionIndex += 1
        updateLiveExam(liveExamUpdateMode: .next)
    }
    
   
    func goToQuestion(index: Int){
        questionIndex = index
        updateLiveExam(liveExamUpdateMode: .next)
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
    
    
}
