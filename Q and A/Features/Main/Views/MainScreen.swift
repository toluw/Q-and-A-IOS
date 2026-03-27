//
//  MainScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 25/03/2026.
//

import SwiftUI

struct MainScreen: View {
    
    
    @State private var selectedTab: MainTab = .cbt
    @State private var isDrawerOpen = false
    
    var body: some View {
        ZStack {
                   
            // Main Content
            mainContent
                .disabled(isDrawerOpen)
                .blur(radius: isDrawerOpen ? 3 : 0)
            
            
            // Overlay
             if isDrawerOpen {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                            closeDrawer()
                        }
                        .transition(.opacity)
                }
            
           
            // Drawer
            HStack {
                NavDrawer {
                    closeDrawer()
                    
                }
                .frame(width: 300)
                .offset(x: isDrawerOpen ? 0 : -320)
                            
                Spacer()
                }
            
        }.animation(.easeInOut(duration: 0.3), value: isDrawerOpen)
    }
    
    @ViewBuilder
    private var mainContent: some View{
        ZStack {
                   
                   // Current Screen
                   contentView
                   
                   // Bottom Navigation
                   VStack {
                       Spacer()
                       CustomBottomNav(
                        selectedTab: $selectedTab,
                        onFabClick: {
                           
                       })
                   }
               }
    }
    
    
    @ViewBuilder
       private var contentView: some View {
           switch selectedTab {
           case .cbt:
               MainCbtScreen()
           case .book:
               MainBookScreen()
           case .video:
               MainVideoScreen()
           case .library:
               MainLibraryScreen()
           }
       }
    
    
    private func openDrawer() {
            isDrawerOpen = true
    }
        
    private func closeDrawer() {
            isDrawerOpen = false
    }
    
}

#Preview {
    MainScreen()
}
