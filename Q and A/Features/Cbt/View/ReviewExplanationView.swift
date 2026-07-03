//
//  ReviewExplanationView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/07/2026.
//

import SwiftUI

struct ReviewExplanationView: View {
    
    let liveExam: LiveExam
    
    
    
    var body: some View {
        ZStack{
            if(liveExam.numberOfAnswer > 1){
                ReviewMultipleAnswerView(liveExam: liveExam)
            }else{
                ReviewAnswerView(liveExam: liveExam)
            }
        }
    }
}

#Preview {
    ReviewExplanationView(liveExam: LiveExam.preview)
}
