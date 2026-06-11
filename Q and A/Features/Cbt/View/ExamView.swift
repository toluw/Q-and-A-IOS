//
//  ExamView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct ExamView: View {
    
    let questionCount: Int
    @Binding var questionIndex: Int
    @Binding var liveExam: LiveExam
    @Binding var examState: ExamState
    let next: () -> Void
    let previous: () -> Void
    let submit: () -> Void
    let gotTo: () -> Void
    let close: () -> Void
    let readMorePassage: () -> Void
    let onMultiSelect: (String) -> Void
    let onMultiDeselect: (String) -> Void
    let onAnswerSelected: (String) -> Void
    @Binding var timeDisplayText: String
    let onCalculatorClicked: () -> Void
 
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
                
                VStack{
                    
                    Text("TIME LEFT")
                        .font(AppFont.regular(12))
                        .foregroundColor(Color("DescColor"))
                    
                    Text(timeDisplayText)
                        .font(AppFont.semi_bold(16))
                        .padding(.top, 2)
                }
                
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
            
            
            HStack{
                
                Button(action: onCalculatorClicked){
                   Image("calculate")
                }
                
               Spacer()
                
                PrimaryButton(buttonText: "Submit", action: submit)
                    .frame(width: 100)
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 10)
            
            
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
                    
                    if(liveExam.numberOfAnswer > 1){
                        Text("Select all possible answers")
                        .italic()
                        .foregroundColor(Color("GreyText"))
                    }
                    
                    if(liveExam.numberOfAnswer > 1){
                        MultiAnswerView(liveExam: $liveExam, onMultiSelect: onMultiSelect, onMultiDeselect: onMultiDeselect).padding(.top, 16)
                    }else{
                       AnswerView(liveExam: $liveExam, onAnswerSelected: onAnswerSelected)
                            .padding(.top, 16)
                    }
                    
                    
                    
                }.frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
               
               
                
            }
            
            Spacer()
            
            ExamNavView(questionCount: questionCount, questionIndex: $questionIndex, liveExam: $liveExam, isExam: true, next: next, previous: previous, goTo: gotTo, submit: submit)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    
    ExamViewPreviewWrapper(questionIndex: 1, liveExam: .preview, examState: ExamState(showFullPassage: false), timeDisplayText: "20:30")
}

struct ExamViewPreviewWrapper: View{
    @State var questionIndex: Int
    @State var liveExam: LiveExam
    @State var examState: ExamState
    @State var timeDisplayText: String
    
    
    init(questionIndex: Int, liveExam: LiveExam, examState: ExamState, timeDisplayText: String) {
        self.questionIndex = questionIndex
        self.liveExam = liveExam
        self.examState = examState
        self.timeDisplayText = timeDisplayText
    }
    
    var body: some View {
        ExamView(questionCount: 10, questionIndex: $questionIndex, liveExam: $liveExam, examState: $examState, next: {}, previous: {}, submit: {}, gotTo: {}, close: {}, readMorePassage: {}, onMultiSelect: {_ in }, onMultiDeselect: {_ in }, onAnswerSelected: {_ in }, timeDisplayText: $timeDisplayText, onCalculatorClicked: {})
    }
}
