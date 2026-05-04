//
//  ExamDescriptionScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 03/05/2026.
//

import SwiftUI

struct ExamDescriptionScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ExamDescriptionScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
