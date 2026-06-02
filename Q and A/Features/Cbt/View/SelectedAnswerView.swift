//
//  SelectedAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 01/06/2026.
//

import SwiftUI

struct SelectedAnswerView: View {
    
    
    let ans: String
    let content: String
    let image: String?
    let shape = RoundedRectangle(cornerRadius: 5)

    
    var body: some View {
        
        if(!content.isEmpty || image != nil){
            
            HStack(alignment: .top){
                
                Text("\(ans.uppercased()).")
                    .font(AppFont.bold(16))
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
                    
                }.padding(.top, 20)
                    .padding(.trailing, 10)
                    .padding(.bottom, 18)
                
                Spacer()
                
            }.frame(maxWidth: .infinity)
                .clipShape(shape)
                .overlay(
                    shape.stroke(Color("ans"), lineWidth: 1)
                )
                .padding(.bottom, 18)
            
        }
        
        
    }
}

#Preview {
    SelectedAnswerView(ans: "a", content: "Wheh there are several images" , image: nil)
}
