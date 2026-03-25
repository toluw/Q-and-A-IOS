//
//  MainScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 25/03/2026.
//

import SwiftUI

struct MainScreen: View {
    
    
    @State private var selectedTab: MainTab = .cbt
    
    var body: some View {
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
}

#Preview {
    MainScreen()
}
