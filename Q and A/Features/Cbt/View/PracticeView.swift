//
//  PracticeView.swift
//  Q and A
//
//  Created by GIGL-PC on 27/06/2026.
//

import SwiftUI

struct PracticeView: View {
    
    let questionCount: Int
    @Binding var questionIndex: Int
    @Binding var liveExam: LiveExam
    @Binding var examState: ExamState
    let next: () -> Void
    let previous: () -> Void
    let gotTo: () -> Void
    let readMorePassage: () -> Void
    let onMultiSelect: (String) -> Void
    let onMultiDeselect: (String) -> Void
    let onAnswerSelected: (String) -> Void
    let onCalculatorClicked: () -> Void
    let onMoveToExplanation: (Bool) -> Void
 
    
    
    var body: some View {
        ScrollViewReader{proxy in
            VStack{
                
                HStack{
                    
                    Spacer()
                    
                    Text("Question \(questionIndex + 1) of \(questionCount)")
                        .foregroundColor(Color("DescColor"))
                        .font(AppFont.medium(16))
                    
                    
                    Spacer()
                    
                    
                    Button(action: onCalculatorClicked){
                       Image("calculate")
                    }
                    
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
                                MultiAnswerView(liveExam: $liveExam, onMultiSelect: {data in
                                    if(liveExam.solution.count < liveExam.answer.convertCommaDelimitedStringToList().count){
                                        
                                        onMultiSelect(data)
                                        
                                        if(liveExam.solution.count == liveExam.answer.convertCommaDelimitedStringToList().count){
                                            
                                            scrollToBottom(proxy: proxy)
                                        }
                                        
                                        
                                       
                                        
                                    }
                                    
                                } , onMultiDeselect: {data in
                                    if(liveExam.solution.count < liveExam.answer.convertCommaDelimitedStringToList().count){
                                        
                                        onMultiDeselect(data)
                                        
                                    }
                                    
                                    
                                }).padding(.top, 16)
                            }else{
                                AnswerView(liveExam: $liveExam, onAnswerSelected: {data in
                                    scrollToBottom(proxy: proxy)
                                    onAnswerSelected(data)
                                })
                                    .padding(.top, 16)
                            }
                            
                            
                            ExplanationStatusView(liveExam: liveExam, onClick: onMoveToExplanation)
                                .padding(.bottom, 24)
                            
                            
                            Color.clear
                                .frame(height: 1)
                                .id("bottom")
                            
                            
                            
                        }.frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        
                    }
                
                
                
                
                Spacer()
                
                ExamNavView(questionCount: questionCount, questionIndex: $questionIndex, liveExam: $liveExam, isExam: false, next: next, previous: previous, goTo: gotTo, submit: {})
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


func scrollToBottom(proxy: ScrollViewProxy){
    DispatchQueue.main.async {
              proxy.scrollTo("bottom", anchor: .bottom)
          }
}

#Preview {
    
    
    
    PracticeViewPreviewWrapper(questionIndex: 1, liveExam: .preview, examState: ExamState(showFullPassage: false))
}

struct PracticeViewPreviewWrapper: View{
    @State var questionIndex: Int
    @State var liveExam: LiveExam
    @State var examState: ExamState
   
    
    
    init(questionIndex: Int, liveExam: LiveExam, examState: ExamState) {
        self.questionIndex = questionIndex
        self.liveExam = liveExam
        self.examState = examState
        
    }
    
    var body: some View {
        
        PracticeView(questionCount: 10, questionIndex: $questionIndex, liveExam: $liveExam, examState: $examState, next: {}, previous: {}, gotTo: {}, readMorePassage: {}, onMultiSelect: {_ in}, onMultiDeselect: {_ in}, onAnswerSelected: {_ in}, onCalculatorClicked: {}, onMoveToExplanation: {_ in})
        
       
    }
}
