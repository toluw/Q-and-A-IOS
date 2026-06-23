//
//  GoToReviewItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 22/06/2026.
//

import SwiftUI

struct GoToReviewItemView: View {
    
    @Binding var goToReview: GoToReview
    let onQuestionSelected: (GoToReview) -> Void
    
    var body: some View {
        Button(action: {
            if(!goToReview.isSeleceted){
                onQuestionSelected(goToReview)
            }
        }){
            
            ZStack{
               
                if(goToReview.isSeleceted){
                    
                    ZStack{
                        
                        Circle()
                            .fill(Color("SecColor"))
                        
                        Text("\(String(goToReview.questionIndex + 1))")
                            .font(AppFont.semi_bold(16))
                            .foregroundColor(Color.white)
                        
                                                              
                    }
                    
                }else{
                    
                    ZStack{
                       
                        Circle()
                            .stroke(
                                goToReview.isCorrect
                                ? Color("right")
                                : Color("err"),
                                lineWidth: 1
                            )
                        
                        Text("\(String(goToReview.questionIndex + 1))")
                            .font(AppFont.semi_bold(16))
                        
                    }
                    
                   
                }
                
            }.frame(width: 64, height: 64)
            
            
        }.buttonStyle(.plain)
    }
}

#Preview {
    GoToReviewItemViewPreviewWrapper(goToReview: GoToReview(questionIndex: 1, isCorrect: true))
}


struct GoToReviewItemViewPreviewWrapper: View{
    
    @State var goToReview: GoToReview
    
    init(goToReview: GoToReview) {
        self.goToReview = goToReview
    }
    
    var body: some View {
        GoToReviewItemView(goToReview: $goToReview, onQuestionSelected: {_ in})
    }
    
}
