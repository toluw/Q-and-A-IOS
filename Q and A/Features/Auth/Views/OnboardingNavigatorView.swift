//
//  OnboardingNavigatorView.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI




struct OnboardingNavigatorView: View {
    
    @StateObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        
        ZStack{
            switch viewModel.onboardingFlow {
            case .intro:
                IntroStackView()
            case .role_selection:
                RoleSelectionScreen()
            }
            
        }.environmentObject(viewModel)
        
       }
}

#Preview {
    OnboardingNavigatorView()
}
