//
//  GreatWorkView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/06/2026.
//

import SwiftUI

struct GreatWorkView: View {
    
    let onItemClicked: () -> Void
    
    var body: some View {
        Button(action: onItemClicked){
            VStack(alignment: .leading){
                
                HStack{
                  
                    Image("correct")
                    
                    Text("Great work, that's absolutely correct")
                        .padding(.leading, 9)
                        .font(AppFont.regular(16))
                    
                    Spacer()
                    
                    
                }.padding(.horizontal, 14)
                    .padding(.top, 11)
                
                HStack{
                    
                    Spacer()
                   
                    Text("Review Explanation")
                        .font(AppFont.regular(14))
                        .italic()
                        .foregroundColor(Color("GreyText"))
                    
                    
                    Image("icon_arrow")
                        .padding(.leading, 15)
                        .padding(.trailing, 12)
                    
                    
                    
                }.padding(.top, 36)
                    .padding(.bottom, 11)
                
            }.frame(maxWidth: .infinity)
                .background(Color("gr"))
                .cornerRadius(7)
                .contentShape(Rectangle())
        }.buttonStyle(.plain)
    }
}

#Preview {
    GreatWorkView(onItemClicked: {})
}
