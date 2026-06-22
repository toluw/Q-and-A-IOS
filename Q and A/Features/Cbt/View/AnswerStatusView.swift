//
//  SwiftUIView.swift
//  Q and A
//
//  Created by GIGL-PC on 20/06/2026.
//

import SwiftUI

struct AnswerStatusView: View {
    
    let answerStatus: AnswerStatus
    
    var body: some View {
       
        ZStack {
            
            if(answerStatus.isCorrect){
                CorrectAnswerView(ans: answerStatus.answer, content: answerStatus.content, image: answerStatus.image)
            }else{
                WrongAnswerView(ans: answerStatus.answer, content: answerStatus.content, image: answerStatus.image)
            }
            
        }

    }
}

#Preview {
    AnswerStatusView(answerStatus: AnswerStatus(answer: "a", content: "A big Image", image: nil, isCorrect: false))
}
