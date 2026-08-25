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
    @ObservedObject var navVM: MainNavViewModel
    
    
    var body: some View {
        
        ZStack{
            
            switch viewModel.state.loginAspect {
            case .Main:
                MainLoginView(viewModel: viewModel, onDismiss: onDismiss, onForgotpassword: onForgotpassword, onLoginSuccess: onLoginSuccess, onUrlClicked: navigateToLink)
            case .SignUp:
                SignUpView(viewModel: viewModel, onUrlClicked: navigateToLink)
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
    
    
   
    
    private func navigateToLink(link: String){
        if let url = URL(string: link){
              UIApplication.shared.open(url)
            //    navVM.navigate(route: .webviewScreen(url: url))
        }
    }
}

#Preview {
    LoginScreen(
      onDismiss: {},
      onForgotpassword: {},
      onLoginSuccess: {_ in }, navVM: MainNavViewModel()
    )
}
