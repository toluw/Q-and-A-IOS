//
//  GoToQuestionItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 04/06/2026.
//

import SwiftUI

struct GoToQuestionItemView: View {
    
    @Binding var goToQuestion: GoToQuestion
    let onQuestionSeelcted: (GoToQuestion) -> Void
    
    var body: some View {
       
        Button(action: {
            if(!goToQuestion.isSeleceted){
                onQuestionSeelcted(goToQuestion)
            }
        }){
            
            ZStack{
               
                if(goToQuestion.isSeleceted){
                    
                    ZStack{
                        
                        Circle()
                            .fill(Color("SecColor"))
                        
                        Text("\(String(goToQuestion.questionIndex + 1))")
                            .font(AppFont.semi_bold(16))
                            .foregroundColor(Color.white)
                        
                                                              
                    }
                    
                }else{
                    
                    ZStack{
                       
                        Circle()
                            .stroke(
                                goToQuestion.hasAttempted
                                ? Color("red")
                                : Color.gray.opacity(0.6),
                                lineWidth: 1
                            )
                        
                        Text("\(String(goToQuestion.questionIndex + 1))")
                            .font(AppFont.semi_bold(16))
                        
                    }
                    
                   
                }
                
            }.frame(width: 64, height: 64)
            
            
        }.buttonStyle(.plain)
        
    }
}

#Preview {
    let goToQuestion = GoToQuestion(questionIndex: 0, hasAttempted: true, isSeleceted: false)
    
    GoToQuestionItemViewPreviewWrapper(goToQuestion: goToQuestion)
}


struct GoToQuestionItemViewPreviewWrapper: View{
    
    @State var goToQuestion: GoToQuestion
    
    init(goToQuestion: GoToQuestion) {
        self.goToQuestion = goToQuestion
    }
    
    var body: some View {
        GoToQuestionItemView(goToQuestion: $goToQuestion, onQuestionSeelcted: {data in})
    }
    
}

