//
//  SubCatViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 18/04/2026.
//

import Foundation

@MainActor
class SubCatViewModel: ObservableObject {
    
    
    var state: SubCatState = SubCatState()
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    func getSubCatExams(cbtId: String, buyerEmail: String?){
        
            
        
        state.isLoading = true
        state.errorMessage = nil
        
        Task{
            do{
              
                let response = try await service.getSubCatExams(cbtId: cbtId, buyerEmail: buyerEmail)
                state.isLoading = false
                
                let subCatExams: [SubCatExams] = response.data.map { data1 in
                    SubCatExams(
                        data: {
                            var copied = data1
                            copied.exams = data1.exams.sorted { $0.isProvisioned && !$1.isProvisioned }
                            return copied
                        }()
                    )
                }
                
                state.initItems = subCatExams
                state.items = subCatExams
                
                
                } catch {
                
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        }
        
    }
    
    func getInitPosition(subCatExams: SubCatExams) -> Int?{
       
        let items = state.initItems.filter { $0.data.subcatId == subCatExams.data.subcatId }
            
            guard let item = items.first else {
                return nil
            }
            
            return state.initItems.firstIndex { $0 == item }
        
    }
    
    func updateExamSelect(
        subCatId: String,
        shouldShuffle: Bool? = nil,
        numQuestion: Int? = nil,
        exam: Exam? = nil
    ) {
        state.examSelectList = state.examSelectList.map { item in
            var newItem = item
            
            guard newItem.subcatId == subCatId else { return newItem }
            
            if let shuffle = shouldShuffle {
                newItem.shouldShuffle = shuffle
            }
            
            if let question = numQuestion {
                newItem.numQuestions = question
            }
            
            if let ex = exam {
                newItem.exam = ex
                newItem.numQuestions = ex.numQuestions
            }
            
            return newItem
        }
    }
    
    
}
