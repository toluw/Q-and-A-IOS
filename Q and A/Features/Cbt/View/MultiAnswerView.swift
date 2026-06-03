//
//  MultiAnswerView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct MultiAnswerView: View {
    
    @Binding var liveExam: LiveExam
    let onMultiSelect: (String) -> Void
    let onMultiDeselect: (String) -> Void
    
    var body: some View {
        VStack{
            
            if(liveExam.solution.contains("a")){
                MultiSelectedAnswerView(ans: "a", content: liveExam.a, image: liveExam.aImage, onMultiDeselect: onMultiDeselect)
            }else{
                
                MultiDeselectedAnswerView(ans: "a", content: liveExam.a, image: liveExam.aImage, onMultiSelected: onMultiSelect)
                
            }
            
            
            if(liveExam.solution.contains("b")){
                MultiSelectedAnswerView(ans: "b", content: liveExam.b, image: liveExam.bImage, onMultiDeselect: onMultiDeselect)
            }else{
                
                MultiDeselectedAnswerView(ans: "b", content: liveExam.b, image: liveExam.bImage, onMultiSelected: onMultiSelect)
                
            }
            
            if(liveExam.solution.contains("c")){
                MultiSelectedAnswerView(ans: "c", content: liveExam.c, image: liveExam.cImage, onMultiDeselect: onMultiDeselect)
            }else{
                
                MultiDeselectedAnswerView(ans: "c", content: liveExam.c, image: liveExam.cImage, onMultiSelected: onMultiSelect)
                
            }
            
            if(liveExam.solution.contains("d")){
                MultiSelectedAnswerView(ans: "d", content: liveExam.d, image: liveExam.dImage, onMultiDeselect: onMultiDeselect)
            }else{
                
                MultiDeselectedAnswerView(ans: "d", content: liveExam.d, image: liveExam.dImage, onMultiSelected: onMultiSelect)
                
            }
            
            if(liveExam.solution.contains("e")){
                MultiSelectedAnswerView(ans: "e", content: liveExam.e, image: liveExam.eImage, onMultiDeselect: onMultiDeselect)
            }else{
                
                MultiDeselectedAnswerView(ans: "e", content: liveExam.e, image: liveExam.eImage, onMultiSelected: onMultiSelect)
                
            }
            
           
           
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    
    MultiAnswerPreviewWrapper(liveExam: .preview)
    
}

struct MultiAnswerPreviewWrapper: View{
    
    @State var liveExam: LiveExam
    
    
    init(liveExam: LiveExam) {
        self.liveExam = liveExam
    }
   
    var body: some View {
        MultiAnswerView(liveExam: $liveExam, onMultiSelect: {data in }, onMultiDeselect: {data in})
    }
    
}

