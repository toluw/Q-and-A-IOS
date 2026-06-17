//
//  MultipleResultView.swift
//  Q and A
//
//  Created by GIGL-PC on 17/06/2026.
//

import SwiftUI

struct MultipleResultView: View {
    
    @State private var selectedIndex: Int = 0
    let results: [ExamResultData]
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
   
    
    
    
    var body: some View {
        VStack{
            
            if(!results.isEmpty){
                
                LoadImageView(url: results[0].examResult.image, width: 64, height: 64)
                    .padding(.top, 10)
                
                Text("EXAM REPORT")
                    .font(AppFont.semi_bold(14))
                    .foregroundColor(Color("DescColor"))
                    .padding(.top, 40)
                
                Text(results[0].examResult.category)
                    .font(AppFont.bold(18))
                    .padding(.top, 14)
                
                CustomTabBar(
                    tabs: results.map { $0.examResult.item },
                    selectedIndex: $selectedIndex
                ).padding(.top, 17)
                
                
                ResultScreen(navVm: navVm, cbtViewModel: cbtViewModel, examResultData: results[selectedIndex], isMultiple: true)
                
                
            }
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MultipleResultView(results: [ExamResultData.preview, ExamResultData.preview, ExamResultData.preview], navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}


