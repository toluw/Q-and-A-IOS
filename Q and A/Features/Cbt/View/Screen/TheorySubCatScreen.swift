//
//  TheorySubCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/04/2026.
//

import SwiftUI

struct TheorySubCatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("No theory subject yet. Please check back later").frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .font(AppFont.regular(14))
                .foregroundColor(Color("empty"))
            
                .padding(.horizontal,16)
            
            Spacer()
            Spacer()
            
        }
    }
}

#Preview {
    TheorySubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
