//
//  DiscussionSolutionView.swift
//  Q and A
//
//  Created by GIGL-PC on 15/07/2026.
//

import SwiftUI

struct DiscussionSolutionView: View {
    
    let liveExam: LiveExam
    let shape = RoundedRectangle(cornerRadius: 5)
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            
            HStack(alignment: .top){
                
                Text("\(liveExam.getAnswerData()[0].answerChar).")
                    .foregroundColor(Color("correct_green"))
                    .font(AppFont.bold(16))
                    .padding(.leading, 10)
                    .padding(.top, 18)
                    .padding(.bottom, 18)
                
                VStack(alignment: .leading){
                    
                    if(!liveExam.getAnswerData()[0].answerText.isEmpty){
                        Text(liveExam.getAnswerData()[0].answerText)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(Color("correct_green"))
                            .font(AppFont.regular(16))
                            .padding(.bottom, 4)
                        
                    }
                    
                    
                    if(liveExam.getAnswerData()[0].image?.isEmpty == false){
                        FullWidthImageView(url: liveExam.getAnswerData()[0].image, placeholderHeight: 36)
                    }
                    
                    
                   
                    
                }.padding(.top, 20)
                    .padding(.trailing, 10)
                    .padding(.bottom, 12)
                
                Spacer()
                
                Image("correct")
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 20)
                
            }
            
            
            if(!liveExam.explanation.isEmpty){
                Text(liveExam.explanation)
                    .lineLimit(4)
                    .truncationMode(.tail)
                    .font(AppFont.regular(13))
                    .padding(.horizontal, 20)
                
            }
            
            if(!(liveExam.explanationImage?.isEmpty ?? true)){
                FullWidthImageView(url: liveExam.explanationImage, placeholderHeight: 72)
                    .padding(.horizontal, 20)
            }
            
            Spacer().frame(height: 16)
            
            
        }.frame(maxWidth: .infinity)
            .clipShape(shape)
            .overlay(
                shape.stroke(Color("correct_green"), lineWidth: 1)
            )
        
       
    }
}

#Preview {
    DiscussionSolutionView(liveExam: LiveExam.preview)
}
