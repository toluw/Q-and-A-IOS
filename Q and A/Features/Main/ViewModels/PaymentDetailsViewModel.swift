//
//  PaymentDetailsViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation

@MainActor
class PaymentDetailsViewModel: ObservableObject{
    
    @Published var state = PaymentDetailsState()
    
    
    private let service: MainServiceProtocol
    
    
      
      init(service:  MainServiceProtocol = MainService()) {
          self.service = service
      }
    
    
    
    
    
    func getPaymentDetails(type: String, reference: String){
        
        state.loadState = .loading
        
        Task{
            do{
               
                let response = try await service.getPaymentDetails(reference: reference, type: type)
                state.loadState = .loaded(response.data.map{
                    $0.title
                })
                
            }catch{
                state.loadState = .error(error.localizedDescription)
            }
            
        }
        
    }
    
}

