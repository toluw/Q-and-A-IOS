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
        VStack{
           
            Spacer().frame(height: 30)
            
            HStack{
                
                Text(item).font(AppFont.medium(18)).padding(.leading, 20)
                
                Spacer()
                
                Image("selector").padding(.trailing, 20)
                
            }
            
            Divider().padding(.top, 14).foregroundColor(Color("Grey"))
            
            
        }.frame(width: .infinity).onTapGesture {
            onItemClicked()
        }
    }
}

#Preview {
    ItemView(item: "Primary", onItemClicked: {})
}
