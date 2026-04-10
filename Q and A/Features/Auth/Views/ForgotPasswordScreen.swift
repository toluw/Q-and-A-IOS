//
//  ForgotPasswordScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 06/04/2026.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    

    @StateObject var viewModel: ForgotPasswordViewModel = .init()
    @ObservedObject var navVm: MainNavViewModel
    
    var body: some View {
        
        ZStack(){
            
            VStack(alignment: .leading){
                
                Image("qanda")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                Spacer()
                Spacer()
                
                VStack(alignment: .center){
                    
                  Text("Forgot your password?")
                        .font(AppFont.semi_bold(16))
                        .foregroundColor(Color.black)
                    
                  Text("Enter the email address associated with your account")
                        .padding(.top, 14)
                        .font(AppFont.regular(14))
                    
                    TextField("Email", text: $viewModel.state.email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .padding(.top, 14)
                    
                    PrimaryButton(buttonText: "Retrieve Password", action: {
                        viewModel.forgotPassword()
                    }).padding(.top, 30)
                    
                }.frame(maxWidth: .infinity)
                
                Spacer()
                Spacer()
                Spacer()
                
                
             
                
            }.padding(.leading, 16)
             .padding(.trailing, 16)
            
            
            if viewModel.state.isLoading {
                   Color.black.opacity(0.4)
                       .ignoresSafeArea()
                   
                   ProgressView()
                       .padding()
                       .background(Color.white)
                       .cornerRadius(10)
               }
            
        }.frame(maxWidth: .infinity)
             .toastBanner(toast: $viewModel.state.errorMessage)
             .onChange(of: viewModel.state.isSuccess){oldValue, newValue in
                 if(newValue){
                     navVm.navigate(route: .confirmOtpScreen(otp: viewModel.state.code, email: viewModel.state.email))
                     viewModel.state.isSuccess = false
                 }
                 
             }
        
      
        
    }
}

#Preview {
    ForgotPasswordScreen(navVm: MainNavViewModel())
}
