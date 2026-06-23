//
//  GoToReviewBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 23/06/2026.
//

import SwiftUI

struct GoToReviewBottomSheetView: View {
    
    let fullQuestionList: [GoToReview]
    
    @StateObject var viewModel: GoToReviewViewModel = .init()
    let onQuestionSelected: (GoToReview) -> Void
    
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
            
            
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20){
                    
                    if(!viewModel.state.questions.isEmpty){
                        ForEach(viewModel.state.questions.indices, id: \.self){index in
                            
                            GoToReviewItemView(goToReview: $viewModel.state.questions[index], onQuestionSelected: {data in
                                
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
                
                
            }
           
              Spacer()
                
            
            if(viewModel.state.selectedQuestion != nil){
                PrimaryButton(buttonText: "Go To", action: {
                    onQuestionSelected(viewModel.state.selectedQuestion!)
                }).frame(maxWidth: .infinity)
                    .padding(.horizontal, 60)
                    .padding(.top, 30)
                    .padding(.bottom, 24)
            }else{
               DisabledButton(buttonText: "Go To")
                    .frame(maxWidth: .infinity)
                        .padding(.horizontal, 60)
                        .padding(.top, 30)
                        .padding(.bottom, 24)
            }
            
        }.frame(maxWidth: .infinity)
            .onAppear {
                viewModel.initQuestions(fullQuestions: fullQuestionList)
            }
    }
}

#Preview {
    
    
    let items = [GoToReview(questionIndex: 0, isCorrect: true),
                 GoToReview(questionIndex: 1, isCorrect: true),
                 GoToReview(questionIndex: 2, isCorrect: false),
                 GoToReview(questionIndex: 3, isCorrect: true),
                 GoToReview(questionIndex: 4, isCorrect: true),
                 GoToReview(questionIndex: 3, isCorrect: false, isSeleceted: true),
                ]
    GoToReviewBottomSheetView(fullQuestionList: items, onQuestionSelected: {dt in})
}
