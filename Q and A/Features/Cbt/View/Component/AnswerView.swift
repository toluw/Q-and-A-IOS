//
//  AnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 01/06/2026.
//

import SwiftUI

struct AnswerView: View {
    
    @Binding var liveExam: LiveExam
    let onAnswerSelected: (String) -> Void
    
    var body: some View {
        VStack{
            
            
            DeselectedAnswerView(ans: "a", content: liveExam.a, image: liveExam.aImage, onAnswerSelected: onAnswerSelected, liveExam: $liveExam)
            
            
                DeselectedAnswerView(ans: "b", content: liveExam.b, image: liveExam.bImage, onAnswerSelected: onAnswerSelected, liveExam: $liveExam)
            
            
            
                DeselectedAnswerView(ans: "c", content: liveExam.c, image: liveExam.cImage, onAnswerSelected: onAnswerSelected, liveExam: $liveExam)
            
            
           
                DeselectedAnswerView(ans: "d", content: liveExam.d, image: liveExam.dImage, onAnswerSelected: onAnswerSelected, liveExam: $liveExam)
            
            
           
                DeselectedAnswerView(ans: "e", content: liveExam.e, image: liveExam.eImage, onAnswerSelected: onAnswerSelected, liveExam: $liveExam)
            
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
        AnswerView(liveExam: $liveExam, onAnswerSelected: {_ in })
    }
    
}
