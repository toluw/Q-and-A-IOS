//
//  PaystackPaymentViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 17/05/2026.
//

import Foundation

@MainActor
class PaystackPaymentViewModel: ObservableObject{
   
    @Published var state: PaystackPaymentState = PaystackPaymentState()
    let authorizationUrl: String
    let reference: String
    
    
    init(authorizationUrl: String, reference: String) {
        self.authorizationUrl = authorizationUrl
        self.reference = reference
    }
    
    
    func verifyPayment(){
        
    }
    
    
}
