//
//  ExamPracticeScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 03/05/2026.
//

import SwiftUI

struct ExamPracticeScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack{
            
            ExamPracticeView(navVm: navVm, items: cbtViewModel.multipleExams, onClose: {
                
                showErrorMessage(message: "Are you sure you want to exit?", actionTitle: "Exit", showCancel: true, action: {
                    navVm.pop()
                })
            })
            
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ExamPracticeScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
