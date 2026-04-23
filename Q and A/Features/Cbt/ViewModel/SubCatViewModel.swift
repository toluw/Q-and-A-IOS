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
                
                var subCatExams: [SubCatExams] = response.data.map { data1 in
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
    
    
}
