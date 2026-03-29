//
//  MainCbtScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI

struct MainCbtScreen: View {
    
    let onShowNavDrawer: () -> Void
    
    var body: some View {
        ScrollView{
            VStack(){
                
                Text("Main CBT").onTapGesture {
                  onShowNavDrawer()
                }
               
            }
        }
        
    }
}

#Preview {
    MainCbtScreen(onShowNavDrawer: {})
}
