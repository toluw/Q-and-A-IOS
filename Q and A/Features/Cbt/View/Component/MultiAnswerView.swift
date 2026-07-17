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
            
           
            MultiDeselectedAnswerView(ans: "a", content: liveExam.a, image: liveExam.aImage, onMultiSelected: onMultiSelect
                                          , liveExam: $liveExam, onMultiDeselected: onMultiDeselect)
                
            
                MultiDeselectedAnswerView(ans: "b", content: liveExam.b, image: liveExam.bImage, onMultiSelected: onMultiSelect, liveExam: $liveExam, onMultiDeselected: onMultiDeselect)
                
            
                MultiDeselectedAnswerView(ans: "c", content: liveExam.c, image: liveExam.cImage, onMultiSelected: onMultiSelect
                                          , liveExam: $liveExam, onMultiDeselected: onMultiDeselect)
                
            
            
        
                MultiDeselectedAnswerView(ans: "d", content: liveExam.d, image: liveExam.dImage, onMultiSelected: onMultiSelect, liveExam: $liveExam, onMultiDeselected: onMultiDeselect)
                
            
            
               MultiDeselectedAnswerView(ans: "e", content: liveExam.e, image: liveExam.eImage, onMultiSelected: onMultiSelect, liveExam: $liveExam, onMultiDeselected: onMultiDeselect)
                
            
            
           
           
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

