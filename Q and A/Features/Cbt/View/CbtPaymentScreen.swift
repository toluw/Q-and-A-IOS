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
                
            }else{
                
                if(viewModel.state.initTransactionErrorMessage != nil){
                    
                    ErrorView(message: viewModel.state.initTransactionErrorMessage!, onRetry: {
                        
                        viewModel.initTransaction()
                        
                    })
                    
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                
                handlePaymentState()
                
            }
            .onChange(of: viewModel.state.initTransactionData){previous, current in
                
                if(viewModel.state.initTransactionData != nil){
                    
                    navVm.navigate(route: .paystackPaymentScreen(authorizationUrl: viewModel.state.initTransactionData!.authorization_url, accessCode: viewModel.state.initTransactionData!.access_code, reference: viewModel.state.initTransactionData!.reference))
                    
                }
                
            }
            .navigationBarBackButtonHidden(true)
    }
    
    
    private func handlePaymentState(){
        
        switch paymentViewModel.paymentState {
        case .initialize:
            initPayment()
        case .success(let reference):
            <#code#>
        case .cancel:
            navVm.pop()
        }
        
    }
    
    private func initPayment(){
       
        let price = cbtViewModel.getExamPayTotalPrice()
        
        let amount = price * 100
        
        let paystackMetaData = cbtViewModel.getPaystackMetadData()
        
        let paystackData = PaystackData(amount: String(amount), email: UserSettings.email ?? "", metadata: paystackMetaData)
        
        viewModel.initTransaction()
        
    }
}

#Preview {
    CbtPaymentScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
