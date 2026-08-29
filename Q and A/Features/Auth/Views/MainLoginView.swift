//
//  MainLoginScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 13/08/2026.
//

import SwiftUI
import GoogleSignIn

import AuthenticationServices
import GoogleSignInSwift

struct MainLoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    @State private var isPasswordVisible = false
    
    let onDismiss: () -> Void
    
    let onForgotpassword: () -> Void
    
    let onLoginSuccess: (UserProfile) -> Void
    
    let onUrlClicked: (String) -> Void
    
    var body: some View {
        ZStack{
            
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
                                .textInputAutocapitalization(.never)
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
                
                
                // Sign up text
                  HStack(spacing: 4) {
                      Text("Not registered?")
                          .foregroundColor(.black)
                      
                      Button(action: {
                          viewModel.state.loginAspect = .SignUp
                      }) {
                          Text("Sign Up")
                              .foregroundColor(.blue)
                              
                      }
                  }
                  .font(AppFont.medium(14))
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.top,10)
                  
                  Spacer()
                      .frame(height: 35)
                  
                  // Divider with "Or"
                  HStack(spacing: 10) {
                      Rectangle()
                          .fill(Color.gray.opacity(0.5))
                          .frame(height: 1)
                      
                      Text("Or")
                          .font(.system(size: 14))
                          .foregroundColor(.gray)
                      
                      Rectangle()
                          .fill(Color.gray.opacity(0.5))
                          .frame(height: 1)
                  }
                
          GoogleSignInButton(scheme: .dark,action: viewModel.googleLogin)
                    .padding(.top, 20)
                
                
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in

                        request.requestedScopes = [
                            .fullName,
                            .email
                        ]

                    },
                    onCompletion: viewModel.handleAppleSignIn
                )
                .signInWithAppleButtonStyle(.whiteOutline)
                .frame(height:40)
                .cornerRadius(8)
                .padding(.top, 20)
                
                
                HStack{
                    
                    Spacer()
                    
                    TermsView(onUrlClicked: {url in
                       onUrlClicked(url)
                    }).padding(.top, 20)
                    
                    Spacer()
                    
                }
                
               
                
                Spacer()
         
                  
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.top, 24)
            
           
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: viewModel.state.isSuccess){oldValue, newValue in
                   if(newValue && viewModel.state.userProfile != nil ){
                       onLoginSuccess(viewModel.state.userProfile!)
                   }
               }
            .toastBanner(toast: $viewModel.state.errorMessage)
    }
}

#Preview {
    MainLoginView(viewModel: LoginViewModel(), onDismiss: {}, onForgotpassword: {}, onLoginSuccess: {dt in
        
    }, onUrlClicked: {dt in})
}
