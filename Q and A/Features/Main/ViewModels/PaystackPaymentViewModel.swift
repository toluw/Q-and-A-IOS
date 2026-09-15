//
//  PaystackPaymentViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 17/05/2026.
//

import Foundation
import FirebaseAnalytics

@MainActor
class PaystackPaymentViewModel: ObservableObject{
   
    @Published var state: PaystackPaymentState = PaystackPaymentState()
    let authorizationUrl: String
    let reference: String
    
    

    private let paystackService: PaystackServiceProtocol
      
      
    
    init(authorizationUrl: String, reference: String, paysstackService: PaystackServiceProtocol = PaystackService()) {
        self.authorizationUrl = authorizationUrl
        self.reference = reference
        self.paystackService = paysstackService
    }
    
    func verifyPaymentInBackground(){
        Task{
            do{
                
                let response = try await paystackService.verifyPayment(reference: reference)
                state.showLoader = false
                if(response.data.status ==  "success"){
                    logPaymentToGoogle(currency: response.data.currency, amount: response.data.amount)
                    state.successPaymentReference = reference
                }
                } catch {
                
                
                
            }
        }
    }
    
    
    private func logPaymentToGoogle(currency: String, amount: Int) {
        let amountInNaira = Double(amount) / 100.0

        Analytics.logEvent(AnalyticsEventPurchase, parameters: [
            AnalyticsParameterValue: amountInNaira,
            AnalyticsParameterCurrency: currency
        ])
    }
    
    
    func verifyPayment(){
        
        state.showLoader = true
        
        state.showWebView = false
    
        state.errorMessage = nil
        
        Task{
            do{
                
                let response = try await paystackService.verifyPayment(reference: reference)
                state.showLoader = false
                if(response.data.status ==  "success"){
                    logPaymentToGoogle(currency: response.data.currency, amount: response.data.amount)
                    state.successPaymentReference = reference
                }else{
                    state.errorMessage = response.data.gateway_response ?? "Transaction could not be completed 3"
                }
            
                } catch {
                
                state.showLoader = false
                    showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", showCancel: false, action: {
                        self.verifyPayment()
                    })
                
            }
        }
        
    }
    
    
}
