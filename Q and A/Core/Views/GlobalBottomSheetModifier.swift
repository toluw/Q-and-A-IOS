//
//  GlobalBottomSheetModifier.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import SwiftUI

struct GlobalBottomSheetModifier: ViewModifier {
    
    @StateObject private var manager = BottomSheetManager.shared
       
       func body(content: Content) -> some View {
           ZStack {
               content
               
               if let sheet = manager.sheet {
                   
                   // 🔥 Dim background
                   Color.black.opacity(0.3)
                       .ignoresSafeArea()
                       .onTapGesture {
                           manager.dismiss()
                       }
                   
                   VStack {
                       Spacer()
                       
                       GlobalBottomSheetView(
                           data: sheet,
                           dismiss: manager.dismiss
                       )
                       .transition(.move(edge: .bottom))
                   }
                   .animation(.easeInOut, value: sheet)
               }
           }
       }
}


