//
//  MultiSelectedAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct MultiSelectedAnswerView: View {
    
    let ans: String
    let content: String
    let image: String?
    let shape = RoundedRectangle(cornerRadius: 5)
    let onMultiDeselect: (String) -> Void
    
    var body: some View {
        if(!content.isEmpty || image != nil){
            
            
            Button(action: {
                onMultiDeselect(ans)
            }){
              
                HStack(alignment: .top){
                    
                        Image("ans_check")
                        .padding(.leading, 10)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                    
                    VStack(alignment: .leading){
                        
                        if(!content.isEmpty){
                            Text(content)
                                .font(AppFont.bold(14))
                                .padding(.bottom, 4)
                            
                        }
                        
                        
                        if(image != nil){
                            FullWidthImageView(url: image, placeholderHeight: 36)
                        }
                        
                    }.padding(.top, 25)
                        .padding(.trailing, 10)
                        .padding(.bottom, 18)
                        .padding(.leading, 8)
                    
                    Spacer()
                    
                }.frame(maxWidth: .infinity)
                    .clipShape(shape)
                    .overlay(
                        shape.stroke(Color("ans"), lineWidth: 1)
                    )
                    .padding(.bottom, 18)
                    .contentShape(Rectangle())
                
            }.buttonStyle(.plain)
            
           
            
        }
        
    }
}

#Preview {
    MultiSelectedAnswerView(ans: "a", content: "Wheh there are several images" , image: nil, onMultiDeselect: {_ in })
}
