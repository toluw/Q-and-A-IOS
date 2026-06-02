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
    
    var body: some View {
        VStack{
            
            HStack{
              
                Button {
                    
                   
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
            
            
            HStack{
                
               Spacer()
                
                PrimaryButton(buttonText: "Submit", action: {})
                    .frame(width: 100)
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 10)
            
            
            ScrollView{
                
            }
            
            Spacer()
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    
    ExamViewPreviewWrapper(questionIndex: 1, liveExam: .preview, examState: ExamState(showFullPassage: false))
}

struct ExamViewPreviewWrapper: View{
    @State var questionIndex: Int
    @State var liveExam: LiveExam
    @State var examState: ExamState
    
    
    init(questionIndex: Int, liveExam: LiveExam, examState: ExamState) {
        self.questionIndex = questionIndex
        self.liveExam = liveExam
        self.examState = examState
    }
    
    var body: some View {
        ExamView(questionCount: 10, questionIndex: $questionIndex, liveExam: $liveExam, examState: $examState)
    }
}
