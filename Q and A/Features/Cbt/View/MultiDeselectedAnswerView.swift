//
//  MultiDeselectedAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct MultiDeselectedAnswerView: View {
    
    let ans: String
    let content: String
    let image: String?
    let shape = RoundedRectangle(cornerRadius: 5)
    let onMultiSelected: (String) -> Void
    
    var body: some View {
        if(!content.isEmpty || image != nil){
            
            Button(action: {
                onMultiSelected(ans)
            } ){
                HStack(alignment: .top){
                    
                    Image("ans_uncheck")
                    .padding(.leading, 10)
                    .padding(.top, 18)
                    .padding(.bottom, 18)
                    
                    VStack(alignment: .leading){
                        
                        if(!content.isEmpty){
                            Text(content)
                                .font(AppFont.regular(14))
                                .padding(.bottom, 4)
                            
                        }
                        
                        
                        if(image != nil){
                            FullWidthImageView(url: image, placeholderHeight: 36)
                        }
                        
                    }.padding(.top, 24)
                        .padding(.trailing, 10)
                        .padding(.bottom, 18)
                        .padding(.leading, 8)
                    
                    Spacer()
                    
                }.frame(maxWidth: .infinity)
                    .clipShape(shape)
                    .overlay(
                        shape.stroke(Color("Grey"), lineWidth: 1)
                    )
                    .contentShape(Rectangle())
                    .padding(.bottom, 18)
                
            }.buttonStyle(.plain)
            
           
        }
    }
}

#Preview {
    MultiDeselectedAnswerView(ans: "a", content: "Welcome to Irabor", image: nil, onMultiSelected: { it in})
}
