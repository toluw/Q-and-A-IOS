//
//  MockExamResultScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 07/06/2026.
//

import SwiftUI

struct MockExamResultScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    let mockId: String
    let mockExamResult: MockExamResult?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MockExamResultScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), mockId: "2", mockExamResult: MockExamResult.preview)
}
