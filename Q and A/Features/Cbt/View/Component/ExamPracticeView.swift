//
//  ExamPracticeView.swift
//  Q and A
//
//  Created by GIGL-PC on 01/07/2026.
//

import SwiftUI

struct ExamPracticeView: View {
    
    
    @ObservedObject var navVm: MainNavViewModel
    @State private var selectedIndex: Int = 0
    let items: [MultipleExam]
    let onClose: () -> Void
    @ObservedObject var cbtViewModel: CbtViewModel
    
    
    
    var body: some View {
        VStack{
            
            
            HStack{
              
                Button {
                    
                   onClose()
                   
                } label: {
                    
                    Image(systemName: "xmark")
                        
                }.buttonStyle(.plain)
                
                
                Spacer()
               
                
                }.frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
            
            if(items.count > 1){
                
                CustomTabBar(
                    tabs: items.map { $0.item },
                    selectedIndex: $selectedIndex
                ).padding(.top, 17)
                
            }
            
            if(!items.isEmpty){
                PracticeScreen(multipleExam: items[selectedIndex], navVm: navVm, cbtViewModel: cbtViewModel)
                    .padding(.top,10)
                    .id(items[selectedIndex].examId) 
            }
            
            Spacer()
            
            
            
            
            
        }
    }
}

#Preview {
    
    let items = [MultipleExam(examId: "1", item: "Maths", liveExamList: [LiveExam.preview, LiveExam.preview]),
                 MultipleExam(examId: "2", item: "English", liveExamList: [LiveExam.preview, LiveExam.preview])]
    
    ExamPracticeView(navVm: MainNavViewModel(), items: items, onClose: {}, cbtViewModel: CbtViewModel())
}
