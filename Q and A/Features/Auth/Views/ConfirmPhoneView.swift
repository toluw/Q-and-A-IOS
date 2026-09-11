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
            
            
            HStack{
                Spacer()
                Button(action: skip, label: {
                    Text("Skip").font(AppFont.medium(14)).contentShape(Rectangle())
                }).padding(.trailing, 24)
                    .padding(.top, 32)
            }
            Image("qanda")
                .frame(maxWidth: .infinity, alignment: .center).padding(.top, 16)
            
            
            Spacer()
            Spacer()
            
            VStack{
                Text("Hi, \(viewModel.state.appleUSer?.name ?? "")!")
                    .font(AppFont.medium(16))
                    
                                
                                
                Text("Add your phone number to your account")
                    .font(AppFont.regular(14))
                    .multilineTextAlignment(.center)
                    .padding(.top, 17)
                
                
                // Phone Number
                TextField("Phone Number (Optional)", text: $phoneNumber)
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
    
    private func skip(){
        let socialSignUpBody = SocialSignupBody(name: viewModel.state.appleUSer?.name ?? "", email: viewModel.state.appleUSer?.email ?? "", phone: "", token: UserSettings.token ?? "", device_id: DeviceManager.shared.getDeviceId(), apple_id: viewModel.state.appleUSer?.appleId)
        
        viewModel.socialSignUp(socialSignUpBody: socialSignUpBody)
    }
    
    private func save(){
        if(viewModel.validatePhoneNumber(phoneNumber: phoneNumber)){
            if(viewModel.state.appleUSer?.name != nil && viewModel.state.appleUSer?.email != nil){
                
                let socialSignUpBody = SocialSignupBody(name: viewModel.state.appleUSer?.name ?? "", email: viewModel.state.appleUSer?.email ?? "", phone: phoneNumber, token: UserSettings.token ?? "", device_id: DeviceManager.shared.getDeviceId(), apple_id: viewModel.state.appleUSer?.appleId)
                
                viewModel.socialSignUp(socialSignUpBody: socialSignUpBody)
                
            }
        }
    }
}

#Preview {
    ConfirmPhoneView(viewModel: LoginViewModel())
}
