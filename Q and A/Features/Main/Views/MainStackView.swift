//
//  MainStackView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/01/2026.
//

import SwiftUI

struct MainStackView: View {
    
    @StateObject private var navVM = MainNavViewModel()
    
    
    var body: some View {
        //  Text("Main Stack")
        NavigationStack(path: $navVM.path) {
                   
            MainScreen()
                .navigationDestination(for: MainRoute.self) { route in
                    destinationView(for: route)
             }
        }
        .environmentObject(navVM)
    }
    
    
    @ViewBuilder
    private func destinationView(for route: MainRoute) -> some View{
        switch route{
        
        case .loginScreen :
            LoginScreen()
            
        }
    }
    
}

#Preview {
    MainStackView()
}
