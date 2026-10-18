//
//  BundlePaymentScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/10/2026.
//

import SwiftUI

struct BundlePaymentScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    @StateObject var viewModel: BundlePaymentViewModel = .init()
    
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
                
                if(viewModel.state.postTransactionErrorMessage != nil){
                    ErrorView(message: viewModel.state.postTransactionErrorMessage!, onRetry: {
                        
                        viewModel.postTranSaction()
                        
                    })
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                
                handlePaymentState()
                
            }.onChange(of: viewModel.state.initTransactionData){previous, current in
                
                if(viewModel.state.initTransactionData != nil){
                    
                    navVm.navigate(route: .paystackPaymentScreen(authorizationUrl: viewModel.state.initTransactionData!.authorization_url, accessCode: viewModel.state.initTransactionData!.access_code, reference: viewModel.state.initTransactionData!.reference))
                    
                }
                
            }
            .onChange(of: viewModel.state.postTransactionSuccess){previous, current in
                
                showSuccessMessage(message: "Your payment was successful, All the exams in the bundles are now unlocked", actionTitle: "Continue", showCancel: false, action: {
                    
                   navVm.pop()
                    
                    
                    
                })
                
            }
            .navigationBarBackButtonHidden(true)
         
    }
    
    
    private func handlePaymentState(){
        
        switch paymentViewModel.paymentState {
        case .initialize:
            initPayment()
        case .success(let reference, let processor):
            handlePaymentSuccess(reference: reference, processor: processor)
        case .cancel:
            navVm.pop()
        }
        
    }
    
    
    private func handlePaymentSuccess(reference: String, processor: Int){
        if let buyerEmail = UserSettings.email {
            
            viewModel.postBundleTranactionBody = cbtViewModel.getBundleTransactionBody(buyerEmail: buyerEmail, reference: reference, processor: processor)
            
           
            viewModel.postTranSaction()
            
        }
    }
    
    private func initPayment(){
        
        let bundlePrice = cbtViewModel.selectedBundles.getTotalPrice()
        
        let price = if(cbtViewModel.agent != nil){
            bundlePrice.discountedPrice
        }else{
            bundlePrice.price
        }
        
        if(UserSettings.phoneNumber?.isNyjaNum() == true){
            
            let amount = price * 100
            let paystackMetaData = cbtViewModel.getBundlePaystackMetaData()
            let paystackData = PaystackData(amount: String(amount), email: UserSettings.email ?? "", metadata: paystackMetaData)
            
            viewModel.paystackData = paystackData
            
            viewModel.initTransaction()
            
        }else{
            navVm.navigate(route: .marketPlaceProductScreen(price: price))
        }
        
        
    }
}

#Preview {
    BundlePaymentScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
