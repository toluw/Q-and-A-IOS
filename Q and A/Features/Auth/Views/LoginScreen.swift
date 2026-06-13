//
//  LoginScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 26/03/2026.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel: LoginViewModel = .init()
    @State private var isPasswordVisible = false
    
    let onDismiss: () -> Void
    
    let onForgotpassword: () -> Void
    
    let onLoginSuccess: (UserProfile) -> Void
    
    
    var body: some View {
        
        ZStack{
            
            if(viewModel.state.isPhoneConfirmationScreen){
                phoneConfirmationView
            }else{
                VStack(alignment: .leading){
                    
                    Button{
                       onDismiss()
                    }label:{
                       Image("back")
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Image("qanda")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    Text("Login")
                        .foregroundColor(Color.black)
                        .font(AppFont.medium(16))
                        .padding(.top, 30)
                    
                    
                    TextField("Email", text: $viewModel.state.email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .padding(.top, 30)
                    
                    
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
                    }.padding(.top, 12)
                    
                    
                    // Forgot password
                    HStack {
                        Spacer()
                        Button{
                            onForgotpassword()
                        }label: {
                            Text("Forgot Password?")
                                .foregroundColor(.red)
                                .font(AppFont.medium(14))
                        }
                        
                    }.padding(.top,12)
                    
                    
                    PrimaryButton(buttonText: "Login", action: {
                        viewModel.login()
                    }).padding(.top, 30)
                    
                    
                    Spacer()
             
                      
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 24)
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
