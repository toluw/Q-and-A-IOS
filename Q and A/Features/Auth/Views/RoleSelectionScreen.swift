//
//  RoleSelectionScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI

struct RoleSelectionScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = RoleSelectionViewModel()
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            
           
            
            Text("I want to:")
                .font(AppFont.medium(18))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 22)
            
            RoleToggleView(selectedRole: $viewModel.selectedRole)
            
            Text(descriptionText)
                .font(AppFont.medium(14))
                .foregroundColor(.black)
                .padding(.top, 28)
            
            VStack(alignment: .leading, spacing: 24) {
                           ForEach(viewModel.features) { feature in
                               FeatureItemView(feature: feature)
                           }
            }.padding(.top, 10)
            
            
            Spacer()
            
            PrimaryButton(buttonText: "Continue", action: {
                
               moveToMain()
                
            })
            
            
                
            
            
        }
        .padding()
        .background(Color("Background"))
    }
    
    
    private func moveToMain(){
        UserSettings.hasLaunchedBefore = true
        appViewModel.appFlow = .main
    }
    
    
    private var descriptionText: String {
           switch viewModel.selectedRole {
           case .buyer:
               return "As a non-seller on Q & A app you have access to the following:"
           case .seller:
               return "As a seller on Q & A app, you have access to the following:"
           }
       }
        
}

#Preview {
    RoleSelectionScreen()
}
