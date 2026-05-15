//
//  MainStackView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/01/2026.
//

import SwiftUI

struct MainStackView: View {
    
    @StateObject private var navVM = MainNavViewModel()
    @StateObject private var cbtViewModel = CbtViewModel()
    @StateObject private var paymentViewModel = PaymentViewModel()
    
    
    var body: some View {
        //  Text("Main Stack")
        NavigationStack(path: $navVM.path) {
                   
            MainScreen(navVm: navVM, cbtViewModel: cbtViewModel)
                .navigationDestination(for: MainRoute.self) { route in
                    destinationView(for: route)
             }
        }
        .environmentObject(navVM)
        .environmentObject(cbtViewModel)
    }
    
    
    @ViewBuilder
    private func destinationView(for route: MainRoute) -> some View{
        switch route{
        
        case .mainCommunityScreen : MainCommunityScreen()
            
            
        case .forgotPasswordScreen: ForgotPasswordScreen(navVm: navVM)
        
        case .confirmOtpScreen(otp: let otp, email: let email): ConfirmOtpScreen(otp: otp,email:email, navVm: navVM)
           
        case .changePassword(email: let email): ChangePasswordScreen(email: email, navVm: navVM)
        case .parentCatScreen(title: let title, cbcId: let cbcId, level: let level, isMock: let isMock):
            ParentCatScreen(title: title, cbcId: cbcId, level: level, isMock: isMock, navVm: navVM, cbtViewModel: cbtViewModel)
        case .examSubCatScreen:
             ExamSubCatScreen(navVm: navVM, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
        case .examCatScreen:
             ExamCatScreen(navVm: navVM, cbtViewModel: cbtViewModel)
        case .mockDescriptionScreen:
             MockDescriptionScreen()
        case .examDescriptionScreen:
             ExamDescriptionScreen(navVm: navVM, cbtViewModel: cbtViewModel)
        case .cbtPaymentScreen:
            CbtPaymentScreen(navVm: navVM, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
        case .examPracticeScreen:
            ExamPracticeScreen(navVm: navVM, cbtViewModel: cbtViewModel)
        case .cbtCartScreen:
            CbtCartScreen(navVm: navVM, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
        }
    }
    
}

#Preview {
    MainStackView()
}
