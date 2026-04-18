//
//  CartView.swift
//  Q and A
//
//  Created by GIGL-PC on 18/04/2026.
//

import SwiftUI

struct CartView: View {
    
    let onCartClicked: () -> Void
    
    var body: some View {
        Button(){
            onCartClicked()
        }label: {
            Image("cart")
        }
    }
}

#Preview {
    CartView(onCartClicked: {})
}
