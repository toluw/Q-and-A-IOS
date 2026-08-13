//
//  LoginScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 26/03/2026.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel: LoginViewModel = .init()
    
    
    let onDismiss: () -> Void
    
    let onForgotpassword: () -> Void
    
    let onLoginSuccess: (UserProfile) -> Void
    
    
    var body: some View {
        
        ZStack{
            
            switch viewModel.state.loginAspect {
            case .Main:
                MainLoginView(viewModel: viewModel, onDismiss: onDismiss, onForgotpassword: onForgotpassword, onLoginSuccess: onLoginSuccess)
            case .SignUp:
                 SignUpView(viewModel: viewModel)
            case .ConfirmPhone:
                ConfirmPhoneView(viewModel: viewModel)
            }
            
            if viewModel.state.isLoading {
                   Color.black.opacity(0.4)
                       .ignoresSafeArea()
                   
                   ProgressView("Logging in...")
                       .padding()
                       .background(Color.white)
                       .cornerRadius(10)
               }
            
           
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
         .onChange(of: viewModel.state.isSuccess){oldValue, newValue in
                if(newValue && viewModel.state.userProfile != nil ){
                    onLoginSuccess(viewModel.state.userProfile!)
                }
            }
         .toastBanner(toast: $viewModel.state.errorMessage)
        
    }
    
    
    @ViewBuilder
    private var phoneConfirmationView: some View{
        
    }
}

#Preview {
    LoginScreen(
      onDismiss: {},
      onForgotpassword: {},
      onLoginSuccess: {_ in }
    )
}
