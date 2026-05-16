//
//  CbtPaymentViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 14/05/2026.
//

import Foundation


@MainActor
class CbtPaymentViewModel: ObservableObject{
    
   
    @Published var state: CbtPaymentState = CbtPaymentState()
    
    var paystackData: PaystackData? = nil
    
    private let cbtService: CbtServiceProtocol
    private let paystackService: PaystackServiceProtocol
      
      init(cbtService: CbtServiceProtocol = CbtService(), paysstackService: PaystackServiceProtocol = PaystackService()) {
          self.cbtService = cbtService
          self.paystackService = paysstackService
      }
    
    
    
    func initTransaction(){
        
        if let data = paystackData{
            
            
            state.isLoading = true
        
            state.initTransactionErrorMessage = nil
            
            Task{
                do{
                    
                    let response = try await paystackService.initiateTransaction(paystackData: data)
                    state.isLoading = false
                    state.initTransactionData = response.data
                
                    } catch {
                    
                    state.isLoading = false
                    state.initTransactionErrorMessage = error.localizedDescription
                }
            }
            
        }
        
    }
    
    
    
    
    
    
}

