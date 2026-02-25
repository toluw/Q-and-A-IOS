//
//  SplashView.swift
//  Q and A
//
//  Created by GIGL-PC on 28/01/2026.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        SplashScreen()
            .onAppear{
              delayAndNavigate()
            }
    }
    
    private func delayAndNavigate(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            appViewModel.appFlow = UserSettings.hasLaunchedBefore ? .main : .intro
        }
    }
   
}

#Preview {
    
    
    SplashView()
        .environmentObject(AppViewModel())
        
}
