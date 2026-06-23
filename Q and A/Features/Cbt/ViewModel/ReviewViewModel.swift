//
//  ReviewViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 22/06/2026.
//

import Foundation


@MainActor
class ReviewViewModel: ObservableObject{
    
    @Published var state: ExamState = ExamState()
    
    
    func reInitState(){
        
        state = ExamState()
    }
    
}
