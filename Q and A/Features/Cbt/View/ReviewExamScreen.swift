//
//  ReviewExamScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 16/06/2026.
//

import SwiftUI

struct ReviewExamScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    let examId: String
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ReviewExamScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), examId: "")
}
