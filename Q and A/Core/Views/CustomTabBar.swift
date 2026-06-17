//
//  CustomTabBar.swift
//  Q and A
//
//  Created by GIGL-PC on 17/06/2026.
//

import SwiftUI

struct CustomTabBar: View {
    
    let tabs: [String]
      @Binding var selectedIndex: Int
   
      var body: some View {
          GeometryReader { geo in
              ScrollView(.horizontal, showsIndicators: false) {
                  HStack(spacing: 0) {
                      ForEach(tabs.indices, id: \.self) { index in
                          TabItem(
                              title: tabs[index],
                              isSelected: selectedIndex == index
                          ) {
                              withAnimation(.easeInOut(duration: 0.2)) {
                                  selectedIndex = index
                              }
                          }
                          // Each tab takes an equal share of the full width.
                          // If that share is too narrow, the text itself will
                          // expand the frame and the ScrollView kicks in.
                          .frame(minWidth: geo.size.width / CGFloat(tabs.count))
                      }
                  }
                  // Make the HStack at least as wide as the screen so tabs
                  // stay centred when they don't overflow.
                  .frame(minWidth: geo.size.width)
              }
          }
          .frame(height: 50)
          .background(Color(.systemBackground))
          .overlay(
              Divider()
                  .background(Color(.systemGray5)),
              alignment: .bottom
          )
      }
}

#Preview {
    CustomTabBarPreviewWrapper(selectedIndex: 1, tabs: ["Books", "Clothe", "Welcome to Kabba"])
}

struct CustomTabBarPreviewWrapper: View {
    
    @State var selectedIndex: Int
    let tabs: [String]
    
    init(selectedIndex: Int, tabs: [String]) {
        self.selectedIndex = selectedIndex
        self.tabs = tabs
    }
    
    var body: some View {
        CustomTabBar(tabs: tabs, selectedIndex: $selectedIndex)
    }
}
