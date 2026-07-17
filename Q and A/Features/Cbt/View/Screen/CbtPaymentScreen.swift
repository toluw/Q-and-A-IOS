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
    
    @Environment(\.modelContext) private var context

    private var repository: ExamCartRepository {
        ExamCartRepository(context: context)
        }
    
    
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
                
            }
            .onChange(of: viewModel.state.initTransactionData){previous, current in
                
                if(viewModel.state.initTransactionData != nil){
                    
                    navVm.navigate(route: .paystackPaymentScreen(authorizationUrl: viewModel.state.initTransactionData!.authorization_url, accessCode: viewModel.state.initTransactionData!.access_code, reference: viewModel.state.initTransactionData!.reference))
                    
                }
                
            }
            .onChange(of: viewModel.state.postTransactionSuccess){previous, current in
                
                showSuccessMessage(message: "Your payment was successful, your CBT content is now unlocked", actionTitle: "Continue", showCancel: false, action: {
                    
                   try? repository.deleteExams()
                    
                    navVm.pop()
                    
                    
                    
                })
                
            }
            .navigationBarBackButtonHidden(true)
    }
    
    
    private func handlePaymentState(){
        
        switch paymentViewModel.paymentState {
        case .initialize:
            initPayment()
        case .success(let reference):
            handlePaymentSuccess(reference: reference)
        case .cancel:
            navVm.pop()
        }
        
    }
    
    private func handlePaymentSuccess(reference: String){
        if let buyerEmail = UserSettings.email {
            
            viewModel.postTransactionBody = cbtViewModel.getTransactionBody(buyerEmail: buyerEmail, reference: reference)
            viewModel.postTranSaction()
            
        }
    }
    
    private func initPayment(){
       
        let price = cbtViewModel.getExamPayTotalPrice()
        
        let amount = price * 100
        
        let paystackMetaData = cbtViewModel.getPaystackMetadData()
        
        let paystackData = PaystackData(amount: String(amount), email: UserSettings.email ?? "", metadata: paystackMetaData)
        
        viewModel.paystackData = paystackData
        
        viewModel.initTransaction()
        
    }
}

#Preview {
    CbtPaymentScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
