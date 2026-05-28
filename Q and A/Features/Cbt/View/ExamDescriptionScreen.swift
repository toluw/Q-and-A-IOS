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
    @StateObject var viewModel: ExamDescriptionViewModel = .init()
    
    var body: some View {
        
        let selectedExam = cbtViewModel.examSelectList[cbtViewModel.examIndex]
        
        
          
        ExamDescriptionView(selectedExam: selectedExam, selectedColor: $viewModel.selectedColor, onStartExam: {
            
        }, onBackClicked: {
            if(cbtViewModel.examIndex == 0){
                navVm.pop()
            }
        })
                .onAppear {
                    viewModel.pickColor()
                }
                .navigationBarBackButtonHidden(true)
                
            
        
        
        
      
        
    }
}
/*
 #Preview {
 ExamDescriptionScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
 }
 */
