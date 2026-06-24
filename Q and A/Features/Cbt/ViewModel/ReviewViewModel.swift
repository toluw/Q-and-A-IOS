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
    @Published var aiContent: String = ""
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    
    func reInitState(){
        
        state = ExamState()
    }
    
    
    func askAiCbt(askAiCbtBody: AskAiCbtBody){
        
       
        
        state.showLoader = true
        
        Task{
            do{
              
                let response = try await service.askAiCbt(askAiCbtBody: askAiCbtBody)
                state.showLoader = false
                aiContent = response.data.content
                
                
                
            } catch {
                state.showLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.askAiCbt(askAiCbtBody: askAiCbtBody)
                })
            }
        }
        
    }
    
}
