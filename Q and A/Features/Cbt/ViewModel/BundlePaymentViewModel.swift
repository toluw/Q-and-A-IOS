//
//  BundlePaymentViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 18/10/2026.
//

import Foundation

@MainActor
class BundlePaymentViewModel: ObservableObject{
    
    
    @Published var state: CbtPaymentState = CbtPaymentState()
    
    var paystackData: PaystackData? = nil
    var postBundleTranactionBody: PostBundleTransactionBody? = nil
    
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
    
    
    func postTranSaction(){
        
        if let transactionBody = postBundleTranactionBody{
            
            state.isLoading = true
            state.postTransactionErrorMessage = nil
            
            
            Task{
                do{
                    
                    let response = try await cbtService.postBundleTransaction(postBundleTransactionBody: transactionBody)
                    state.isLoading = false
                    state.postTransactionSuccess = true
                
                    } catch {
                    
                    state.isLoading = false
                    state.postTransactionErrorMessage = error.localizedDescription
                }
            }
        }
        
     
        
    }
    
    
    
    
}
