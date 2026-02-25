//
//  SplashScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 30/01/2026.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        
        ZStack{
            
            Color("Background")
                .ignoresSafeArea()
            
            
            VStack(spacing: 30){
                
                
                
                Spacer()
                
                Image("splash_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 109, height: 109)
                
                Text("welcome_message")
                    .font(AppFont.semi_bold(16))
                
                Spacer()
                    
                
            }
        }
        
       

    }
}

#Preview {
    SplashScreen()
}
