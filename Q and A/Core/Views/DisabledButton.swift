//
//  DisabledButton.swift
//  Q and A
//
//  Created by GIGL-PC on 02/05/2026.
//

import SwiftUI

struct DisabledButton: View {
    
    let buttonText: String
    
        
        var body: some View {
            
                Text(buttonText)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(Color("disabled"))
                    .font(AppFont.medium(16))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            
        }
}

#Preview {
    DisabledButton(buttonText: "Continue")
}
