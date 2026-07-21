//
//  ReviewAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 19/06/2026.
//

import SwiftUI

struct ReviewAnswerView: View {
    
    let liveExam: LiveExam
    
    var body: some View {
        
        VStack{
           
            if(!liveExam.solution.isEmpty && liveExam.solution[0].lowercased() != liveExam.answer.convertCommaDelimitedStringToList()[0].lowercased()){
                
                WrongAnswerView(ans: liveExam.solution[0].uppercased(), content: liveExam.getSolution(), image: liveExam.getSolutionImage())
                    .padding(.bottom, 18)
                    
                
            }
            
            CorrectAnswerView(ans: liveExam.answer.convertCommaDelimitedStringToList()[0].uppercased(), content: liveExam.getAnswer(), image: liveExam.getAnswerImage())
            
            
            if(liveExam.solution.isEmpty || liveExam.solution[0].lowercased() != liveExam.answer.convertCommaDelimitedStringToList()[0].lowercased()){
                
                
                HStack{
                  
                    Text("The correct answer is option \(liveExam.answer.convertCommaDelimitedStringToList()[0].uppercased())")
                        .foregroundColor(Color("correct_green"))
                        .font(AppFont.medium(18))
                        .padding(.top, 18)
                    
                    Spacer()
                    
                }
                
             
            }
            
        }.frame(maxWidth: .infinity)
        
    }
}

#Preview {
    ReviewAnswerView(liveExam: LiveExam.preview)
}
