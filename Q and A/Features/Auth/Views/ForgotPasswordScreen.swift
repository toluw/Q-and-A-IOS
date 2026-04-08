//
//  ForgotPasswordScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 06/04/2026.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ForgotPasswordViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading){
            Button{
               dismiss()
            }label:{
               Image("back")
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            
            Image("qanda")
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            
            
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
                    
                }).padding(.top, 30)
                
            }.frame(maxWidth: .infinity)
            
            Spacer()
            
            
         
            
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 16)
         .padding(.trailing, 16)
    }
}

#Preview {
    ForgotPasswordScreen()
}
