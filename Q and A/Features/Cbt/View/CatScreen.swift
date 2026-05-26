//
//  CatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 25/05/2026.
//

import SwiftUI

struct CatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
