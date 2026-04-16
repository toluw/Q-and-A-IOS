//
//  EmptyState.swift
//  Q and A
//
//  Created by GIGL-PC on 16/04/2026.
//

import SwiftUI

struct EmptyStateView: View {
    
    let title: String
    
    var body: some View {
        VStack{
            
            Image("empty_state")
            
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
