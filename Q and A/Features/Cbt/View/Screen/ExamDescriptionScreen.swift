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
        
        
        ZStack{
            
            ExamDescriptionView(selectedExam: selectedExam, selectedColor: $viewModel.selectedColor, onStartExam: {
                
                viewModel.getCbtQuestions(examId: selectedExam.exam.examId, buyerEmail: UserSettings.email ?? "")
                
            }, onBackClicked: {
                if(cbtViewModel.examIndex == 0){
                    navVm.pop()
                }
            })
                
            if(viewModel.state.showLoader){
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView()
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
         .onAppear {
                    viewModel.pickColor()
            }
         .navigationBarBackButtonHidden(true)
         .onChange(of: viewModel.state.data){ previous, current in
             
             if let data = viewModel.state.data{
                 
                 initExam(selectedExam: selectedExam, data: data)
                 
                 navVm.replaceTop(route: .examLoaderScreen)
                 
             }
             
         }
          
         
    }
    
    private func initExam(selectedExam: ExamSelect, data: [ExamQuestion]){
        cbtViewModel.initLiveExam(examQuestions: data, examSelect: selectedExam)
        
        if(cbtViewModel.examIndex == 0){
            cbtViewModel.examDuration = TimeInterval(cbtViewModel.getTotalExamTime())
        }
        
        cbtViewModel.questionIndex = 0
        
        cbtViewModel.updateLiveExam(liveExamUpdateMode: .normal)
        
        
        
    }
}
/*
 #Preview {
 ExamDescriptionScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
 }
 */
