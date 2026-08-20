//
//  WrongAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 19/06/2026.
//

import SwiftUI

struct WrongAnswerView: View {
    
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
                            .font(AppFont.regular(14))
                            .padding(.bottom, 4)
                        
                    }
                    
                    
                    if(image?.isEmpty == false){
                        FullWidthImageView(url: image, placeholderHeight: 36)
                    }
                    
                }.padding(.top, 20)
                    .padding(.trailing, 10)
                    .padding(.bottom, 18)
                
                Spacer()
                
                Image("wrong")
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 20)
                
            }.frame(maxWidth: .infinity)
                .clipShape(shape)
                .overlay(
                    shape.stroke(Color("wrong_red"), lineWidth: 1)
                )
                
            
        }
        
        
    }
}

#Preview {
    WrongAnswerView(ans: "a", content: "Wheh there are several images" , image: nil)
}
