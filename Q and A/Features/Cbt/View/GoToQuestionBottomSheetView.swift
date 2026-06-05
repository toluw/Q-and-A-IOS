//
//  GoToQuestionBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 05/06/2026.
//

import SwiftUI

struct GoToQuestionBottomSheetView: View {
    
    let fullQuestionList: [GoToQuestion]
    
    @StateObject var viewModel: GoToQuestionViewModel = .init()
    let onQuestionSelected: (GoToQuestion) -> Void
    
    let columns = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
    
    var body: some View {
        VStack{
            
            Text("Choose a question to go to").font(AppFont.regular(16))
                .padding(.top, 36)
            
            
           
                
                LazyVGrid(columns: columns, spacing: 20){
                    
                    if(!viewModel.state.questions.isEmpty){
                        ForEach(viewModel.state.questions.indices, id: \.self){index in
                            
                            GoToQuestionItemView(goToQuestion: $viewModel.state.questions[index], onQuestionSeelcted: {data in
                                
                                viewModel.selectQuestion(question: data)
                                viewModel.state.selectedQuestion = data
                                
                            })
                            
                        }
                    }
                    
                   
                    
                }.padding(.horizontal, 16)
                    .padding(.top, 40)
                
                
            
            
            if(viewModel.state.showSeeAllButton){
                HStack{
                    
                   Spacer()
                    
                    Button(action: {
                        viewModel.seeAll(fullQuestions: fullQuestionList)
                    }){
                      Text("SEE ALL")
                            .font(AppFont.medium(16))
                            .foregroundColor(Color("SecColor"))
                            .padding(5)
                            .contentShape(Rectangle())
                    }.buttonStyle(.plain)
                    
                }.padding(.horizontal, 16)
            }
            
            if(viewModel.state.selectedQuestion != nil){
                PrimaryButton(buttonText: "Go To", action: {
                    onQuestionSelected(viewModel.state.selectedQuestion!)
                }).frame(maxWidth: .infinity)
                    .padding(.horizontal, 60)
                    .padding(.top, 30)
                    .padding(.bottom, 16)
            }else{
               DisabledButton(buttonText: "Go To")
                    .frame(maxWidth: .infinity)
                        .padding(.horizontal, 60)
                        .padding(.top, 30)
                        .padding(.bottom, 16)
            }
            
        }.frame(maxWidth: .infinity)
            .onAppear {
                viewModel.initQuestions(fullQuestions: fullQuestionList)
            }
    }
}

#Preview {
    
    let fullQuestions: [GoToQuestion] = [
        GoToQuestion(questionIndex: 0, hasAttempted: true),
        GoToQuestion(questionIndex: 1, hasAttempted: false),
        GoToQuestion(questionIndex: 2, hasAttempted: false),
        GoToQuestion(questionIndex: 3, hasAttempted: false),
        GoToQuestion(questionIndex: 4, hasAttempted: false, isSeleceted: true),
        GoToQuestion(questionIndex: 5, hasAttempted: false),
        GoToQuestion(questionIndex: 6, hasAttempted: false),
        GoToQuestion(questionIndex: 7, hasAttempted: true),
        GoToQuestion(questionIndex: 8, hasAttempted: false),
        GoToQuestion(questionIndex: 9, hasAttempted: false),
        GoToQuestion(questionIndex: 10, hasAttempted: false),
        GoToQuestion(questionIndex: 11, hasAttempted: false),
        GoToQuestion(questionIndex: 12, hasAttempted: false),
        GoToQuestion(questionIndex: 13, hasAttempted: false),
    ]
    
    GoToQuestionBottomSheetView(fullQuestionList: fullQuestions, onQuestionSelected: {data in})
}
