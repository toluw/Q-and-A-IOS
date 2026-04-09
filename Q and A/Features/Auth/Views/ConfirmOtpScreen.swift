//
//  ConfirmOtpScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import SwiftUI


struct ConfirmOtpScreen: View {
    
    let otp: String
    let email: String
    @State var enteredCode = ""
    @State var wrongCodeMessage: ToastData? = nil
    @ObservedObject var navVm: MainNavViewModel
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            Image("qanda")
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            
            Spacer()
            Spacer()
            
            VStack(alignment: .center){
                
                Text("Enter password reset code")
                    .font(AppFont.semi_bold(16))
                    .foregroundColor(Color.black)
                
                Text("We have sent a six digit code to your email address. Please enter the code below to proceed")
                    .padding(.top, 14)
                    .multilineTextAlignment(.center)
                    .font(AppFont.regular(14))
                
                TextField("Code", text: $enteredCode)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding(.top, 14)
                
                PrimaryButton(buttonText: "Proceed", action: {
                    confirmCode()
                }).padding(.top, 30)
                
                Text("Please check your spam if you cannot find the code")
                    .padding(.top, 12)
                    .font(AppFont.regular(14))
                
            }.frame(maxWidth: .infinity)
            
            Spacer()
            Spacer()
            Spacer()
            
            
            
        }.toastBanner(toast: $wrongCodeMessage)
            .frame(maxWidth: .infinity)
            .padding(.leading, 16)
             .padding(.trailing, 16)
        
    }
    
    private func confirmCode(){
        wrongCodeMessage = nil
        if(enteredCode == ""){
            wrongCodeMessage = ToastData(message: "Please enter code", type: .error)
            return
        }
        
        if(enteredCode != otp){
            wrongCodeMessage = ToastData(message: "You have entered the wrong code", type: .error)
            return
        }
        
        navVm.navigate(route: .changePassword(email: email))
        
        
    }
}

#Preview {
    ConfirmOtpScreen(otp: "849300", email: "", navVm: MainNavViewModel())
}
