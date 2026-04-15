//
//  MainStackView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/01/2026.
//

import SwiftUI

struct MainStackView: View {
    
    @StateObject private var navVM = MainNavViewModel()
    
    
    var body: some View {
        //  Text("Main Stack")
        NavigationStack(path: $navVM.path) {
                   
            MainScreen(navVm: navVM)
                .navigationDestination(for: MainRoute.self) { route in
                    destinationView(for: route)
             }
        }
        .environmentObject(navVM)
    }
    
    
    @ViewBuilder
    private func destinationView(for route: MainRoute) -> some View{
        switch route{
        
        case .mainCommunityScreen : MainCommunityScreen()
            
            
        case .forgotPasswordScreen: ForgotPasswordScreen(navVm: navVM)
        
        case .confirmOtpScreen(otp: let otp, email: let email): ConfirmOtpScreen(otp: otp,email:email, navVm: navVM)
           
        case .changePassword(email: let email): ChangePasswordScreen(email: email, navVm: navVM)
        case .parentCatScreen(title: let title, cbcId: let cbcId, level: let level, isMock: let isMock):
            ParentCatScreen(title: title, cbcId: cbcId, level: level, isMock: isMock)
        case .examSubCatScreen:
             ExamSubCatScreen()
        case .examCatScreen:
             ExamCatScreen()
        case .mockDescriptionScreen:
             MockDescriptionScreen()
        }
    }
    
}

#Preview {
    MainStackView()
}
