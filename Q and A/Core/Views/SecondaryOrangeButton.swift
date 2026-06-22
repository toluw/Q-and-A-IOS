//
//  SwiftUIView.swift
//  Q and A
//
//  Created by GIGL-PC on 22/06/2026.
//

import SwiftUI

struct SecondaryOrangeButton: View {
    
    let buttonText: String
    let action: () -> Void
    let shape = RoundedRectangle(cornerRadius: 5)
    
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.white)
                .font(AppFont.medium(16))
                .foregroundColor(Color("SecColor"))
                .clipShape(shape)
                .overlay(
                    shape.stroke(Color("SecColor"), lineWidth: 0.3)
                )
        }
       
    }
}

#Preview {
    SecondaryOrangeButton(buttonText: "Continue", action: {})
}
