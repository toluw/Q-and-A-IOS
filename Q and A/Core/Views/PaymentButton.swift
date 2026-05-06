//
//  PaymentButton.swift
//  Q and A
//
//  Created by GIGL-PC on 06/05/2026.
//

import SwiftUI

struct PaymentButton: View {

    let buttonText: String
    let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(buttonText)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(Color.black)
                    .font(AppFont.semi_bold(16))
                    .foregroundColor(Color("PayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
}

#Preview {
    PaymentButton(buttonText: "Continue", action: {})
}
