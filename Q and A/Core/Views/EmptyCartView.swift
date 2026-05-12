//
//  EmptyCartView.swift
//  Q and A
//
//  Created by GIGL-PC on 10/05/2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct EmptyCartView: View {
    
    let onContinueShopping: () -> Void
    
    var body: some View {
        
        VStack{
            
            Text("Oops! Look like you have no item in your cart yet")
                .font(AppFont.regular(14))
                .padding(.horizontal, 16)
                
            
            
            
            AnimatedImage(name: "empty_cart.gif")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.vertical, 30)
            
            
            PrimaryButton(buttonText: "Continue Shopping", action: onContinueShopping)
            .padding(.horizontal, 16)
            
            
            
        }.frame(maxWidth: .infinity)
        
    }
}

#Preview {
    EmptyCartView(onContinueShopping: {})
}
