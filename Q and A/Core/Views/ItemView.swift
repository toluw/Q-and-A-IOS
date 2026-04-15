//
//  ItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 15/04/2026.
//

import SwiftUI

struct ItemView: View {
    
    
    let item: String
    let onItemClicked: () -> Void
    
    var body: some View {
        
        Button(action: onItemClicked){
            
            VStack{
               
               
                HStack{
                    
                    Text(item).font(AppFont.medium(18)).padding(.leading, 20)
                    
                    Spacer()
                    
                    Image("selector").padding(.trailing, 20)
                    
                }.padding(.top,28)
                
                Rectangle().fill(Color("Grey")).frame(height: 1).padding(.top, 14)
                
                
            }.frame(maxWidth: .infinity) // 👈 expand width
             .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
        
     
           
    }
}

#Preview {
    ItemView(item: "Primary", onItemClicked: {})
}
