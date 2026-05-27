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
          
        ExamDescriptionView(selectedExam: selectedExam, selectedColor: viewModel.selectedColor, onStartExam: {
            
        })
                .onAppear {
                    viewModel.pickColor()
                }
                .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            if(cbtViewModel.examIndex == 0){
                                navVm.pop()
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                }
            
        
        
        
      
        
    }
}
/*
 #Preview {
 ExamDescriptionScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
 }
 */
