//
//  ExamViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 03/06/2026.
//

import Foundation

@MainActor
class ExamViewModel: ObservableObject{
    
    @Published var state: ExamState = ExamState()
    
    
    func reInitState(){
        
        state = ExamState()
    }
    
}
