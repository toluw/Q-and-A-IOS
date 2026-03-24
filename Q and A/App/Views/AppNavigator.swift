//
//  AppNavigator.swift
//  Q and A
//
//  Created by GIGL-PC on 28/01/2026.
//

import SwiftUI



struct AppNavigator: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        
        switch appViewModel.appFlow {
        case .splash:
            SplashView()
        case .intro:
            OnboardingNavigatorView()
        case.main:
            MainStackView()
        }
        
    }
}

#Preview {
    AppNavigator()
        .environmentObject(AppViewModel())
}
