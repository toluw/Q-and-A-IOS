//
//  ExamDescriptionViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 27/05/2026.
//

import Foundation

@MainActor
class ExamDescriptionViewModel: ObservableObject{
    
    
    @Published var selectedColor: String = "cb0"
    
    let colourList: [String] = ["cb0", "cb1", "cb2", "cb3"]
    
    @Published var state: ExamDescriptionState = ExamDescriptionState()
    
    
    
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    
    
    
    func pickColor() {
            selectedColor = colourList.randomElement() ?? "cb0"
    }
    
    
    func getExamQuestions(examId: String, buyerEmail: String){
        
       
        
        state.showLoader = true
        
        Task{
            do{
              
                let response = try await service.getCbtQuestions(examId: examId, buyerEmail: buyerEmail)
                state.showLoader = false
                state.data = response.data
                
                
                
            } catch {
                state.showLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.getExamQuestions(examId: examId, buyerEmail: buyerEmail)
                })
            }
        }
        
    }
    
   
    
    
}

