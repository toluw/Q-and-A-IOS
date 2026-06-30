//
//  ViewSolutionButton.swift
//  Q and A
//
//  Created by GIGL-PC on 30/06/2026.
//

import SwiftUI

struct ViewSolutionButton: View {
    
    let action: () -> Void
    let buttonTxt: String
    
    var body: some View {
        Button(action: action) {
            Text("View Solution")
                .frame(maxWidth: .infinity)
                .padding(.top, 14)
                .padding(.bottom, 14)
                .background(Color("bg"))
                .font(AppFont.medium(16))
                .foregroundColor(Color("tx"))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

#Preview {
    ViewSolutionButton(action: {}, buttonTxt: "View Solution")
}
