//
//  FanQuizResultScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 07/06/2026.
//

import SwiftUI

struct FanQuizResultScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    let examId: String?
    let examResultData: ExamResultData?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FanQuizResultScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), examId: "2", examResultData: ExamResultData.preview)
}
