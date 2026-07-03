//
//  ReviewExplanationScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 02/07/2026.
//

import SwiftUI

struct ReviewExplanationScreen: View {
    
    
    let liveExam: LiveExam
    let isViewSolution: Bool
    let examId: String
    @ObservedObject var navVm: MainNavViewModel
    @StateObject var viewModel: ReviewViewModel = .init()
    
    var body: some View {
       
        VStack{
            
            ScrollView{
                
                VStack{
                    
                    if(isViewSolution){
                        SolutionView(liveExam: liveExam)
                            .padding(.bottom, 18)
                            .padding(.top, 20)
                    }else{
                        ReviewExplanationView(liveExam: liveExam)
                            .padding(.bottom, 18)
                            .padding(.top, 20)
                    }
                    
                    
                    if(!liveExam.explanation.isEmpty){
                        Text(liveExam.explanation).font(AppFont.regular(16)).padding(.top,1)
                    }
                    
                    if(!(liveExam.explanationImage?.isEmpty ?? true)){
                        FullWidthImageView(url: liveExam.explanationImage, placeholderHeight: 60)
                    }
                    
                    
                }.padding(.horizontal, 16)
                
            }
            
            Spacer()
            
            
            HStack{
                
                Spacer()
                
                VStack{
                   
                    if(liveExam.questionImage?.isEmpty ?? true && liveExam.passageImage?.isEmpty ?? true && liveExam.aImage?.isEmpty ?? true && liveExam.bImage?.isEmpty ?? true && liveExam.cImage?.isEmpty ?? true &&
                       liveExam.dImage?.isEmpty ?? true &&
                       liveExam.eImage?.isEmpty ?? true){
                        
                        
                        OrangeButton(buttonText: "Ask AI", action: askAi).padding(.bottom, 10)
                        
                        
                    }
                    
                    SecondaryOrangeButton(buttonText: "Join Discussion", action: joinDiscussion)
                    
                }.frame(width: 180)
                
                Spacer()
                
                
                
            }.padding(.bottom, 35)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: viewModel.aiContent) { _,  content in
            
                if(!content.isEmpty){
                    viewModel.aiContent = ""
                    navVm.navigate(route: .aiCbtScreen(content: content))
                }
               
                
            }
        .toolbar {
                
                // Title
                ToolbarItem(placement: .principal) {
                    Text("Explanation").font(AppFont.regular(18))
                }
                
                
            }
        
    }
    
    
    private func askAi(){
        
       
        let askAiCbtBody = AskAiCbtBody(exam_id: examId, question_id: liveExam.questionId)
        viewModel.askAiCbt(askAiCbtBody: askAiCbtBody)
        
    }
    
    
    private func joinDiscussion(){
        
    }
}

#Preview {
    ReviewExplanationScreen(liveExam: LiveExam.preview, isViewSolution: false, examId: "", navVm: MainNavViewModel())
}
