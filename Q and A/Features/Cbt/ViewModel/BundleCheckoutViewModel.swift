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
