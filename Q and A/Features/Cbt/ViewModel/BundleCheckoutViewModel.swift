//
//  BundleCheckoutViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import Foundation

@MainActor
class BundleCheckoutViewModel: ObservableObject{
    
    @Published var state = BundleCheckoutState()
    
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    
    
    func setTotalPrice(bundles: [UserBundle]){
        state.totalPrice = bundles.getTotalPrice()
    }
    
    
    func onTextInputChanged(text: String){
        
        if(text.count == 6){
            state.inputError = ""
            applyCode(text: text)
            
        }else{
            
            if(text.isEmpty){
                state.inputError = ""
            }else{
                state.inputError = "Invalid code"
            }
            
        }
        
    }
    
    
    func applyCode(text: String){
        state.showBlockedLoader = true
        Task{
            do{
                let validateCodeBody = ValidateCodeBody(buyer_email: UserSettings.email ?? "", code: text)
                let response = try await service.validateCode(validateCodeBody: validateCodeBody)
                state.showBlockedLoader = false
                state.inputtedCode = ""
                state.agent = response.data
                state.hasAppliedCode = true
                state.paymentText = "Pay \((state.totalPrice?.discountedPrice ?? 0).formatted(.currency(code: "NGN")))"
                
                
                
                
            }catch {
                state.showBlockedLoader = false
                state.inputtedCode = ""
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.applyCode(text: text)
                })
            }
        }
        
    }
    
    
    func removeRefferal(){
        state.agent = nil
        state.hasAppliedCode = false
        state.paymentText = "Pay \((state.totalPrice?.price ?? 0).formatted(.currency(code: "NGN")))"
        
    }
    
  
    
    func updateViews(){
        
        if let it = state.totalPrice{
            state.originalPrice = it.originalPrice.formatted(.currency(code: "NGN"))
            state.bundlePrice = it.price.formatted(.currency(code: "NGN"))
            let discount = it.price - it.discountedPrice
            state.referralDiscount = "-\(discount.formatted(.currency(code: "NGN")))"
            state.total = it.discountedPrice.formatted(.currency(code: "NGN"))
            let bundleSavings = it.originalPrice - it.price
            state.bundleSavingsLabel = "You save \(bundleSavings.formatted(.currency(code: "NGN"))) with the bundle"
            state.paymentText = "Pay \(state.bundlePrice)"
            
            
        }
        
       
        
    }
    
}
