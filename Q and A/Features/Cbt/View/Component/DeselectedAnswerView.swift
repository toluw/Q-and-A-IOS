//
//  DeselectedAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct DeselectedAnswerView: View {
    
    
    let ans: String
    let content: String
    let image: String?
    let shape = RoundedRectangle(cornerRadius: 5)
    let onAnswerSelected: (String) -> Void
    @Binding var liveExam: LiveExam

    
    var body: some View {
        
        if(!content.isEmpty || image != nil){
            
            Button(action: {
                if(!liveExam.solution.contains(ans)){
                    onAnswerSelected(ans)
                }
                
            } ){
                HStack(alignment: .top){
                    
                    Text("\(ans.uppercased()).")
                        .font(AppFont.bold(16))
                        .padding(.leading, 10)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                    
                    VStack(alignment: .leading){
                        
                        if(!content.isEmpty){
                            Text(content)
                                .font(liveExam.solution.contains(ans) ? AppFont.semi_bold(14) : AppFont.regular(14))
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
                        shape.stroke(Color(liveExam.solution.contains(ans) ? "ans" : "Grey"), lineWidth: 1)
                    )
                    .contentShape(Rectangle())
                    .padding(.bottom, 18)
                
            }.buttonStyle(.plain)
            
           
        }
        
        
    }
    
}

/*
 
 #Preview {
 DeselectedAnswerView(ans: "a", content: "Wheh there are several images" , image: nil, onAnswerSelected: {_ in })
 }
 */
