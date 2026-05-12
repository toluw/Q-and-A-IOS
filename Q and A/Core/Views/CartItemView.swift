//
//  CartItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 10/05/2026.
//

import SwiftUI

struct CartItemView: View {
    
    let title: String
    let price: Int
    let onDelete: () -> Void
    
    var body: some View {
        VStack{
           
            HStack{
                
                VStack(alignment: .leading){
                    
                    Text(title).font(AppFont.regular(16))
                    
                    Text(price, format: .currency(code: "NGN"))
                        .font(AppFont.regular(16))
                        .foregroundColor(Color("label"))
                        .padding(.top, 2)
                    
                }.padding(.leading, 16)
                 
                
                Spacer()
                
                Button(action: onDelete){
                   
                    Image("delete")
                    
                }.buttonStyle(.plain)
                    .padding(.trailing, 16)
                    .padding(.leading, 8)
                
                
            }.frame(maxWidth: .infinity)
                .padding(.top, 14)
            
            Rectangle().fill(Color("Grey")).frame(height: 1).padding(.top, 14)
            
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    CartItemView(title: "English", price: 200, onDelete: {})
}
