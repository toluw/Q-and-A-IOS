//
//  SignUpView.swift
//  Q and A
//
//  Created by GIGL-PC on 13/08/2026.
//

import SwiftUI
import GoogleSignIn

import AuthenticationServices
import GoogleSignInSwift

struct SignUpView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    let onUrlClicked: (String) -> Void
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            Button{
                viewModel.state.loginAspect = .Main
            }label:{
                Image("back")
                    .padding(.top, 24)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            
            Image("qanda")
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            Spacer()
            Spacer()
            
            VStack(alignment: .center){
                
              Text("Sign Up?")
                    .font(AppFont.semi_bold(16))
                    .foregroundColor(Color.black)
                
              Text("Sign up with Google or Apple")
                    .padding(.top, 2)
                    .font(AppFont.regular(14))
                
                
                GoogleSignInButton(scheme: .dark,action: viewModel.googleLogin)
                          .padding(.top, 40)
                      
                      
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
                      
                    
                          
                TermsView(onUrlClicked: {url in
                   onUrlClicked(url)
                }).padding(.top, 30)
                       
                
                
                
                
                
            }.frame(maxWidth: .infinity)
            
            Spacer()
            Spacer()
            Spacer()
            
        
            
           
            
           
            
            
            
        }.padding(.horizontal, 16)
    }
}

#Preview {
    SignUpView(viewModel: LoginViewModel(), onUrlClicked: {data in})
}
