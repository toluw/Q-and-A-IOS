//
//  CbtPaymentScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 03/05/2026.
//

import SwiftUI

struct CbtPaymentScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    @StateObject var viewModel: CbtPaymentViewModel = .init()
    
    var body: some View {
        ZStack{
            
            if(viewModel.state.isLoading){
                
                ProgressView()
                
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                
                handlePaymentState()
                
            }
    }
    
    
    private func handlePaymentState(){
        
        switch paymentViewModel.paymentState {
        case .initialize:
            <#code#>
        case .success(let reference):
            <#code#>
        case .cancel:
            <#code#>
        }
        
    }
}

#Preview {
    CbtPaymentScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
