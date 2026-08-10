//
//  QuoteView.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import SwiftUI

struct QuoteView: View {
    
    let name: String
    let content: String
    let onClose: () -> Void
   
    
    var body: some View {
        
        HStack(alignment: .top){
            
            VStack(alignment: .leading){
                
                Text(name)
                    .foregroundColor(Color("text_grey"))
                        .font(AppFont.medium(14))
                        
                
                Text(
                   content
                ).foregroundColor(Color("text_grey"))
                    .font(AppFont.regular(12))
                    .lineLimit(2)
                    .truncationMode(.tail)
                    
                
                
            }.padding(.leading, 8)
                .padding(.trailing, 4)
                .padding(.vertical, 15)
            
            
            Spacer()
            
            Button(action: onClose){
               
                Image("closes")
                    .renderingMode(.template)
                    .foregroundStyle(.red)
                    .padding(.top, 15)
                    .padding(.trailing, 14)
                    .contentShape(Rectangle())
                
                
            }.buttonStyle(.plain)
            
        }.frame(maxWidth: .infinity)
            .background(Color("FaintGrey").opacity(0.15))
            .cornerRadius(8)
        
    }
}

#Preview {
    QuoteView(name: "James Justin", content: "Welcome onboard guys", onClose: {})
}
