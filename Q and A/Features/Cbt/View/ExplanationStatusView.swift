//
//  ExplanationStatusView.swift
//  Q and A
//
//  Created by GIGL-PC on 30/06/2026.
//

import SwiftUI

struct ExplanationStatusView: View {
    
    let liveExam: LiveExam
    let onClick: (Bool) -> Void
    
    var body: some View {
        ZStack {
            switch liveExam.getExplanationStatus() {
            case .viewSolution:
                ViewSolutionButton(action: {
                    onClick(true)
                }, buttonTxt: liveExam.explanation.isEmpty && (liveExam.explanationImage?.isEmpty ?? true) ? "See answer" : "Review Explanation").padding(.top, 10)
            case .showCorrectAnswer:
                GreatWorkView(onItemClicked: {
                    onClick(false)
                }).padding(.top, 18)
            case .showWrongAnswer:
                IncorrectOptionView(onItemClicked: {
                    onClick(false)
                }).padding(.top, 18)
            }
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    ExplanationStatusView(liveExam: LiveExam.preview, onClick: {it in})
}
