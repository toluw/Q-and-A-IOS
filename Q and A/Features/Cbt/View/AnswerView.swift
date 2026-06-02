//
//  AnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 01/06/2026.
//

import SwiftUI

struct AnswerView: View {
    
    @Binding var liveExam: LiveExam
    let char: String
    let onAnswerSelected: (String) -> Void
    
    var body: some View {
        VStack{
            
            if(liveExam.solution.contains("a")){
                SelectedAnswerView(ans: "a", content: liveExam.a, image: liveExam.aImage)
            }else{
                DeselectedAnswerView(ans: "a", content: liveExam.a, image: liveExam.aImage, onAnswerSelected: onAnswerSelected)
            }
            
            if(liveExam.solution.contains("b")){
                SelectedAnswerView(ans: "b", content: liveExam.b, image: liveExam.bImage)
            }else{
                DeselectedAnswerView(ans: "b", content: liveExam.b, image: liveExam.bImage, onAnswerSelected: onAnswerSelected)
            }
            
            if(liveExam.solution.contains("c")){
                SelectedAnswerView(ans: "c", content: liveExam.c, image: liveExam.cImage)
            }else{
                DeselectedAnswerView(ans: "c", content: liveExam.c, image: liveExam.cImage, onAnswerSelected: onAnswerSelected)
            }
            
            if(liveExam.solution.contains("d")){
                SelectedAnswerView(ans: "d", content: liveExam.d, image: liveExam.dImage)
            }else{
                DeselectedAnswerView(ans: "d", content: liveExam.d, image: liveExam.dImage, onAnswerSelected: onAnswerSelected)
            }
            
            if(liveExam.solution.contains("e")){
                SelectedAnswerView(ans: "e", content: liveExam.e, image: liveExam.eImage)
            }else{
                DeselectedAnswerView(ans: "e", content: liveExam.e, image: liveExam.eImage, onAnswerSelected: onAnswerSelected)
            }
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    
    
   
    
    AnswerPreviewWrapper(liveExam: .preview)
}

struct AnswerPreviewWrapper: View{
    
    @State var liveExam: LiveExam
    
    
    init(liveExam: LiveExam) {
        self.liveExam = liveExam
    }
   
    var body: some View {
        AnswerView(liveExam: $liveExam, char: "c", onAnswerSelected: {_ in })
    }
    
}
