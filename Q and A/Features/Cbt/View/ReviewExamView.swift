//
//  ReviewExamView.swift
//  Q and A
//
//  Created by GIGL-PC on 18/06/2026.
//

import SwiftUI

struct ReviewExamView: View {
    
    let questionCount: Int
    @Binding var questionIndex: Int
    @Binding var liveExam: LiveExam
    @Binding var examState: ExamState
    let next: () -> Void
    let previous: () -> Void
    let gotTo: () -> Void
    let close: () -> Void
    let readMorePassage: () -> Void
    
    
    
    
    var body: some View {
        
        VStack{
            
            HStack{
              
                Button {
                    
                close()
                   
                } label: {
                    
                    Image(systemName: "xmark")
                        
                }.buttonStyle(.plain)
                
                
                Spacer()
                
                Text("Question \(questionIndex + 1) of \(questionCount)")
                    .foregroundColor(Color("DescColor"))
                    .font(AppFont.medium(16))
                
                
                Spacer()
                
               
                
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
            
            ScrollView{
                
                VStack(alignment: .leading){
                    
                    Spacer().frame(height: 16)
                    
                    if(examState.showFullPassage){
                        FullPassageView(passage: liveExam.passage)
                            
                    }else{
                        PassageView(passage: liveExam.passage, passageImage: liveExam.passageImage, passageVideo: liveExam.passageVideo, passageBook: liveExam.passageBook, onReadMore: readMorePassage)
                            
                   }
                    
                    
                    if(!liveExam.question.isEmpty  && liveExam.question != "-"){
                        Text(liveExam.question)
                            .font(AppFont.regular(16))
                    }
                    
                    if(liveExam.questionImage != nil){
                        FullWidthImageView(url: liveExam.questionImage, placeholderHeight: 72)
                            .padding(.top, 5)
                    }
                    
                    
                    
                    
                }.frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                
            }
            
            Spacer()
            
            ExamNavView(questionCount: questionCount, questionIndex: $questionIndex, liveExam: $liveExam, isExam: false, next: next, previous: previous, goTo: gotTo, submit: {})
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
}

#Preview {
    ReviewExamPreviewWrapper(questionIndex: 1, liveExam: LiveExam.preview, examState: ExamState())
}

struct ReviewExamPreviewWrapper: View{
    @State var questionIndex: Int
    @State var liveExam: LiveExam
    @State var examState: ExamState
    
    
    
    init(questionIndex: Int, liveExam: LiveExam, examState: ExamState) {
        self.questionIndex = questionIndex
        self.liveExam = liveExam
        self.examState = examState
       
    }
    
    var body: some View {
        
        
        
        ReviewExamView(questionCount: 10, questionIndex: $questionIndex, liveExam: $liveExam, examState: $examState, next: {}, previous: {}, gotTo: {}, close: {}, readMorePassage: {})
    }
}
