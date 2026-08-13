//
//  ConfirmPhoneView.swift
//  Q and A
//
//  Created by GIGL-PC on 13/08/2026.
//

import SwiftUI

struct ConfirmPhoneView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @State private var phoneNumber = ""
    
    var body: some View {
        VStack{
            
            Image("qanda")
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            Spacer()
            Spacer()
            
            VStack{
                Text("Hi, Toluwase!")
                    .font(AppFont.medium(16))
                    
                                
                                
                Text("Please enter your phone number to complete your registration")
                    .font(AppFont.regular(14))
                    .multilineTextAlignment(.center)
                    .padding(.top, 17)
                
                
                // Phone Number
                TextField("Phone Number", text: $phoneNumber)
                    .font(.system(size: 16))
                    .keyboardType(.phonePad)
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                    )
                    .padding(.top, 22)
                
                
                PrimaryButton(buttonText: "Save", action: {
                    save()
                    
                }).padding(.top, 25)
                              
                
            }.padding(.horizontal, 16)
            
            Spacer()
            Spacer()
            Spacer()
            
            
            
        }.frame(maxWidth: .infinity)
         .toastBanner(toast: $viewModel.state.errorMessage)
    }
    
    private func save(){
        if(viewModel.validatePhoneNumber(phoneNumber: phoneNumber)){
            
        }
    }
}

#Preview {
    ConfirmPhoneView(viewModel: LoginViewModel())
}
