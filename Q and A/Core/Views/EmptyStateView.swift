//
//  EmptyState.swift
//  Q and A
//
//  Created by GIGL-PC on 16/04/2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct EmptyStateView: View {
    
    let title: String
    
    var body: some View {
        VStack{
            
            AnimatedImage(name: "empty_bx.gif")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
            
            Text(title)
                .font(AppFont.regular(14))
                .foregroundColor(Color("empty"))
                .padding(.top,14)
            
        }
    }
}

#Preview {
    EmptyStateView(title: "No Categories Found")
}
