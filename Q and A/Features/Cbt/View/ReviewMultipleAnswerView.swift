//
//  ReviewMultipleAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 20/06/2026.
//

import SwiftUI

struct ReviewMultipleAnswerView: View {
    
    let liveExam: LiveExam
    
    
    var body: some View {
        VStack{
            LazyVStack(spacing: 18){
                ForEach(liveExam.getAnswerStatus()){anwerStatus in
                   AnswerStatusView(answerStatus: anwerStatus)
                }
                
                if(liveExam.solution.isEmpty || liveExam.solution.sorted() != liveExam.answer.convertCommaDelimitedStringToList().sorted()){
                    
                    
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
    }
}

#Preview {
    ReviewMultipleAnswerView(liveExam: .preview)
}
