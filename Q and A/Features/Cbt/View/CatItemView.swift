//
//  CatItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 16/04/2026.
//

import SwiftUI

struct CatItemView: View {
    
    let title: String
    let onItemClicked: () -> Void
    
    
    var body: some View {
        
        Button(action: onItemClicked){
        
            VStack{
               
                HStack{
                    
                    
                    Text(title)
                        .font(AppFont.medium(18))
                    
                    Spacer()
                    
                    Image("selector")
                    
                    
                }.frame(maxWidth: .infinity)
                    .padding(.top, 28)
                    .padding(.bottom, 28)
                    .padding(.leading, 18)
                    .padding(.trailing, 18)
                
            }.frame(maxWidth: .infinity)
             .background(Color.white)
             .cornerRadius(20)
             .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
        
    }
}

#Preview {
    CatItemView(title: "Professional", onItemClicked: {})
}
