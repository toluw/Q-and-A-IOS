//
//  PaystackPaymentScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 16/05/2026.
//

import SwiftUI

struct PaystackPaymentScreen: View {
    
    
    @ObservedObject var paymentViewModel: PaymentViewModel
    @ObservedObject var navVm: MainNavViewModel
    @StateObject private var viewModel: PaystackPaymentViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    init(authorizationUrl: String, reference: String, paymentViewModel: PaymentViewModel, navVm: MainNavViewModel) {
        _viewModel = StateObject(
            wrappedValue: PaystackPaymentViewModel(
                authorizationUrl: authorizationUrl,
                reference: reference
            )
        )
        
        self.paymentViewModel = paymentViewModel
        self.navVm = navVm
    }
    
    
    var body: some View {
        ZStack{
            
            if(viewModel.state.showWebView){
                PaystackWebView(viewModel: viewModel).ignoresSafeArea()
                
            }
            
            if(viewModel.state.showLoader){
                ProgressView()
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: viewModel.state.errorMessage){previous, current in
                if let errorMessage = viewModel.state.errorMessage{
                    showErrorMessage(message: errorMessage, actionTitle: "Close", showCancel: false, action: {
                        paymentViewModel.paymentState = .cancel
                        navVm.pop()
                    })
                }
            }
            .onChange(of: scenePhase) { previous, current in

                       if current == .active {

                           viewModel.verifyPaymentInBackground()
                       }
                   }
            .onChange(of: viewModel.state.successPaymentReference){previous, current in
                
                if let reference = viewModel.state.successPaymentReference{
                    paymentViewModel.paymentState = .success(reference: reference)
                    navVm.pop()
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                        showNoticeMessage(message: "Payment processing can take between 1 to 5 minutes. Do not close this page until payment is confirmed. Ignore if not making payment", actionTitle:  "Close Page", showCancel: true, action: {
                            paymentViewModel.paymentState = .cancel
                            navVm.pop()
                        })
                        
                    } label: {
                        
                            Image(systemName: "xmark")
                            
                        
                    }
                }
            }
    }
    
    #Preview {
        PaystackPaymentScreen(
            authorizationUrl: "", reference: "", paymentViewModel: PaymentViewModel(), navVm: MainNavViewModel()
        )
    }
}
