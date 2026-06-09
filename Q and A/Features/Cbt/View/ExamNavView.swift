//
//  ExamNavView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct ExamNavView: View {
    
    let questionCount: Int
    @Binding var questionIndex: Int
    @Binding var liveExam: LiveExam
    let isExam: Bool
    let next: () -> Void
    let previous: () -> Void
    let goTo: () -> Void
    let submit: () -> Void
    let shape = RoundedRectangle(cornerRadius: 6)
    
    
    
    var body: some View {
        
       
        
        HStack{
            if(questionIndex > 0){
                
                Button(action: previous){
                    HStack{
                        Image("arrow-left")
                            .padding(.horizontal, 5)
                            .padding(.vertical, 8)
                        
                        Text("PREVIOUS")
                            .font(AppFont.medium(16))
                            .padding(.vertical, 8)
                            .padding(.trailing, 5)
                    }.contentShape(Rectangle())
                    
                }.buttonStyle(.plain)
                
            }else{
                Spacer().frame(width: 60)
            }
            
            Spacer()
            
            
            Button(action: goTo){
                HStack{
                    Text("Go to")
                        .font(AppFont.regular(15))
                        .padding(.vertical, 8)
                        .padding(.leading, 8)
                        .padding(.trailing, 4)
                    
                    Image("goto_arrow")
                        .padding(.vertical, 8)
                        .padding(.trailing, 5)
                    
                }.contentShape(Rectangle())
                    .clipShape(shape)
                    .overlay(
                        shape.stroke(Color("SecColor"), lineWidth: 1)
                    )
            }.buttonStyle(.plain)
                
                Spacer()
                
                if(questionIndex < (questionCount - 1)){
                    Button(action: next){
                        HStack{
                            
                            Text("NEXT")
                                .font(AppFont.medium(16))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 5)
                               
                            
                            Image("arrow-right")
                                .padding(.trailing, 5)
                                .padding(.vertical, 8)
                            
                            
                        }.contentShape(Rectangle())
                        
                    }.buttonStyle(.plain)
                }else if(isExam){
                    PrimaryButton(buttonText: "Submit", action: submit)
                        .frame(width: 100)
                }
           
            
            
        }.frame(maxWidth: .infinity)
    }
}


#Preview {
    
    ExamNavViewPreviewWrapper(questionIndex: 1, liveExam: .preview, examState: ExamState(showFullPassage: false))
}

struct ExamNavViewPreviewWrapper: View{
    @State var questionIndex: Int
    @State var liveExam: LiveExam
    @State var examState: ExamState
    
    
    init(questionIndex: Int, liveExam: LiveExam, examState: ExamState) {
        self.questionIndex = questionIndex
        self.liveExam = liveExam
        self.examState = examState
    }
    
    var body: some View {
        ExamNavView(questionCount: 10, questionIndex: $questionIndex, liveExam: $liveExam, isExam: true, next: {}, previous: {}, goTo: {}, submit: {})
    }
}
