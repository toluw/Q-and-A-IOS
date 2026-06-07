//
//  ResultScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 07/06/2026.
//

import SwiftUI

struct ResultScreen: View {
  
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    let examResultData: ExamResultData
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ResultScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(),  examResultData: ExamResultData.preview)
}
