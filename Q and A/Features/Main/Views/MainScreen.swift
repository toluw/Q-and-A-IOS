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
                NavDrawer(onMenuSelected: handleMenuSelection)
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
               MainCbtScreen(){
                   openDrawer()
               }
                   
               
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
    
    private func handleMenuSelection(navMenu: NavMenu){
        
        closeDrawer()
        
        switch (navMenu){
            
        case .community:
            <#code#>
        case .aiAssistance:
            <#code#>
        case .fanQuiz:
            <#code#>
        case .myLibrary:
            <#code#>
        case .myCbt:
            <#code#>
        case .myPortal:
            <#code#>
        case .shareApp:
            <#code#>
        case .myCart:
            <#code#>
        case .signOut:
            <#code#>
        case .signIn:
            <#code#>
        case .reportCopyright:
            <#code#>
        case .contactUs:
            <#code#>
        case .faq:
            <#code#>
        case .termsAndConditions:
            <#code#>
        case .about:
            <#code#>
        case .editProfile:
            <#code#>
        }
    }
    
}

#Preview {
    MainScreen()
}
