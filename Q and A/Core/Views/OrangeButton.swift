//
//  OrangeButton.swift
//  Q and A
//
//  Created by GIGL-PC on 22/06/2026.
//

import SwiftUI

struct OrangeButton: View {
    
    
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(Color("SecColor"))
                .font(AppFont.medium(16))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

#Preview {
    OrangeButton(buttonText: "Continue", action: {})
}
