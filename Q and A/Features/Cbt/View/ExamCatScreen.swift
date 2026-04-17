//
//  ExamCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 14/04/2026.
//

import SwiftUI

struct ExamCatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ExamCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
