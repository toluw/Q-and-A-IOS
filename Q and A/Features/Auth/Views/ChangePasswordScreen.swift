//
//  ChangePasswordScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 09/04/2026.
//

import SwiftUI


struct ChangePasswordScreen: View {
    
    let email: String
    @StateObject var viewModel: ChangePasswordViewModel = .init()
    @ObservedObject var navVm: MainNavViewModel
    @State private var isPasswordVisible = false
    
    var body: some View {
        ZStack(){
            
            VStack(alignment: .leading){
                
               
                Image("qanda")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                Spacer()
                Spacer()
                
                VStack(alignment: .center){
                    
                    Text("Set new password")
                          .font(AppFont.semi_bold(16))
                          .foregroundColor(Color.black)
                    
                    // Password
                    ZStack(alignment: .trailing) {
                        Group {
                            if isPasswordVisible {
                                TextField("Password", text: $viewModel.state.password)
                                 } else {
                                        SecureField("Password", text: $viewModel.state.password)
                                       }
                                   }
                                   .textFieldStyle(.roundedBorder)
                                   
                                   
                                   Button {
                                       isPasswordVisible.toggle()
                                   } label: {
                                       Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                   }
                                   .padding(.trailing, 8)
                    }.padding(.top, 30)
                    
                    //Confirm Password
                    ZStack(alignment: .trailing) {
                        Group {
                            if isPasswordVisible {
                                TextField("Confirm Password", text: $viewModel.state.confirmPassword)
                                 } else {
                                        SecureField("Confirm Password", text: $viewModel.state.password)
                                       }
                                   }
                                   .textFieldStyle(.roundedBorder)
                                   
                                   
                                   Button {
                                       isPasswordVisible.toggle()
                                   } label: {
                                       Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                   }
                                   .padding(.trailing, 8)
                    }.padding(.top, 20)
                    
                    
                    PrimaryButton(buttonText: "Save", action: {
                        viewModel.changePassword(email: email)
                    }).padding(.top, 30)
                    
                }.frame(maxWidth: .infinity)
                
                
                Spacer()
                Spacer()
                Spacer()
                
                
            }
            
            
            
            
            if viewModel.state.isLoading {
                   Color.black.opacity(0.4)
                       .ignoresSafeArea()
                   
                   ProgressView("Logging in...")
                       .padding()
                       .background(Color.white)
                       .cornerRadius(10)
               }
            
        }.frame(maxWidth: .infinity)
            .padding(.leading, 16)
             .padding(.trailing, 16)
             .onChange(of: viewModel.state.isSuccess){oldValue, newValue in
                 if(newValue){
                     showSuccessMessage(message: "Password changed successfully, login to proceed", actionTitle: "Login", action: {
                         
                         viewModel.showLogin = true
                     })
                 }
                 
             }
             .sheet(isPresented: $viewModel.showLogin){
                 LoginScreen(
                     onDismiss: {
                         viewModel.showLogin = false
                     }, onForgotpassword: {
                         viewModel.showLogin = false
                         navVm.pop(n: 2)
                     }, onLoginSuccess: {userProfile in
                         viewModel.showLogin = false
                         navVm.pop(n: 3)
                     }
                     
                 )
             }
             .toastBanner(toast: $viewModel.state.errorMessage)
    }
}

#Preview {
    ChangePasswordScreen(email: "", navVm: MainNavViewModel())
}
