//
//  AiCbtScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 24/06/2026.
//

import SwiftUI

struct AiCbtScreen: View {
    
    let content: String
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                
                GeminiFormattedView(content: content).padding(.top, 16)
                
                
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            
            // Title
            ToolbarItem(placement: .principal) {
                Text("AI").font(AppFont.regular(18))
            }
            
            
        }
       
        
        
    }
}

#Preview {
    AiCbtScreen(content: "## Title\nThis is **bold** text and **another bold** word.")
}
