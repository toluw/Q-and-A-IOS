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
        VStack{
            
            
            HStack{
              
                Button {
                    
                    showErrorMessage(message: "Are you sure you want to exit?", actionTitle: "Exit", showCancel: true, action: {
                        navVm.pop()
                    })
                   
                } label: {
                    
                    Image(systemName: "xmark")
                        
                }.buttonStyle(.plain)
                
                
                Spacer()
               
                
                }.frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
            
            if(cbtViewModel.multipleExams.count > 1){
                
                CustomTabBar(
                    tabs: cbtViewModel.multipleExams.map { $0.item },
                    selectedIndex: $selectedIndex
                ).padding(.top, 17)
                
            }
            
            if(!cbtViewModel.multipleExams.isEmpty){
                PracticeScreen(multipleExam: cbtViewModel.multipleExams[selectedIndex], navVm: navVm)
            }
            
            Spacer()
            
            
            
            
            
        }
    }
}

#Preview {
    ExamPracticeScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
