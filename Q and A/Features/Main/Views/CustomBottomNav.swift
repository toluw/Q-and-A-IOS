//
//  CustomBottomNav.swift
//  Q and A
//
//  Created by GIGL-PC on 25/03/2026.
//

import SwiftUI

struct CustomBottomNav: View {
    
    @Binding var selectedTab: MainTab
    let onFabClick: () -> Void
    
    var body: some View {
        ZStack(alignment: Alignment.center){
            
            // Background Shape
            CurvedTabBarShape()
                .fill(Color.white)
                .shadow(radius: 5)
                .frame(height: 80)
            
        }
        
        HStack {
                       
                       tabItem(icon: "ic_cbt", title: "CBT", tab: .cbt)
                       
                       Spacer()
                       
            tabItem(icon: "ic_book", title: "Book", tab: .book)
                       
                        // space for FAB
            Spacer()
                       
            tabItem(icon: "ic_video", title: "Video", tab:.video)
                       
                       Spacer()
                       
                       tabItem(icon: "ic_library", title: "Library", tab: .library)
                   }
                   .padding(.horizontal, 20)
        
        // Floating Button
                 VStack {
                     Button {
                         onFabClick()
                     } label: {
                         Image(systemName: "ic_community")
                             .foregroundColor(.white)
                             .frame(width: 60, height: 60)
                             .background(Color("FabColour"))
                             .clipShape(Circle())
                             .shadow(radius: 5)
                     }
                     .offset(y: -30)
                     
                     
                 }
    }
    
    private func tabItem(icon: String, title: String, tab: MainTab) -> some View {
           Button {
               selectedTab = tab
           } label: {
               VStack(spacing: 4) {
                   Image(systemName: icon)
                   Text(title)
                       .font(AppFont.medium(12))
               }
               .foregroundColor(selectedTab == tab ? Color("SecColor") : .gray)
           }
       }
}

#Preview {
    CustomBottomNavPreviewWrapper()
}

struct CustomBottomNavPreviewWrapper: View{
    
    @State var selectedTab: MainTab = .cbt
    
    var body: some View {
        CustomBottomNav(selectedTab: $selectedTab, onFabClick: {})
    }
    
    
    
}
