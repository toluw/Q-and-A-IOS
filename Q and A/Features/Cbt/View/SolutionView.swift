//
//  SolutionView.swift
//  Q and A
//
//  Created by GIGL-PC on 01/07/2026.
//

import SwiftUI

struct SolutionView: View {
    
    let liveExam: LiveExam
    
    var body: some View {
        LazyVStack(spacing: 18){
           
            
            ForEach(liveExam.getAnswerData()){answerData in
               
                CorrectAnswerView(ans: answerData.answerChar, content: answerData.answerText, image: answerData.image)
                
            }
            
            
                
                
                HStack{
                  
                    Text("The correct answer is option \(liveExam.answer.uppercased())")
                        .foregroundColor(Color("correct_green"))
                        .font(AppFont.medium(18))
                        .padding(.top, 2)
                    
                    Spacer()
                    
                }
                
             
            
        }
    }
}

#Preview {
    SolutionView(liveExam: LiveExam.preview)
}
