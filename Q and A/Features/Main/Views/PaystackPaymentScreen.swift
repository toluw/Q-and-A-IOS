//
//  PaystackPaymentScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 16/05/2026.
//

import SwiftUI

struct PaystackPaymentScreen: View {
    
    let authorizationUrl: String
    let accessCode: String
    let reference: String
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PaystackPaymentScreen(
        authorizationUrl: "", accessCode: "", reference: "", paymentViewModel: PaymentViewModel()
    )
}
