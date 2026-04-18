//
//  TabSubCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/04/2026.
//

import SwiftUI

struct TabSubCatScreen: View {
    
    enum Tab {
        case objective
        case theory
    }
    
    @State private var selectedTab: Tab = .objective
    @Namespace private var animation
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    var body: some View {
        VStack {
            
            // Tabs
            HStack(spacing: 0) {
                tabItem(title: "Objective", tab: .objective)
                tabItem(title: "Theory", tab: .theory)
            }
            .frame(height: 50)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.top, 20)
            
            // Content
            ZStack {
                if selectedTab == .objective {
                    SubCatScreen(navVm: navVm, cbtViewModel: cbtViewModel)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                } else {
                    TheorySubCatScreen(navVm: navVm, cbtViewModel: cbtViewModel)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: selectedTab)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func tabItem(title: String, tab: Tab) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedTab = tab
            }
        } label: {
            ZStack {
                if selectedTab == tab {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("SecColor"))
                        .matchedGeometryEffect(id: "tabBackground", in: animation)
                }
                
                Text(title)
                    .foregroundColor(selectedTab == tab ? .white : Color("SecColor"))
                    .font(AppFont.medium(18))
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    TabSubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
