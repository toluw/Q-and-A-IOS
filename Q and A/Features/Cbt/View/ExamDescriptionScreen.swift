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
          
            VStack{
                
                HStack{
                    
                    ZStack{
                        LoadImageView(url: selectedExam.image, width: 43 , height: 43)
                    }.frame(width: 64, height: 64)
                        .background(Color.white).opacity(0.1)
                    
                    VStack{
                          
                        Text(selectedExam.category)
                            .font(AppFont.semi_bold(18))
                            .foregroundColor(Color.white)
                        
                        Text(selectedExam.item)
                            .font(AppFont.medium(18))
                            .foregroundColor(Color.white)
                        
                    }.padding(.leading, 15)
                     
                    
                }.frame(maxWidth: .infinity)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.bottom, 30)
                
                
                VStack{
                    
                    ScrollView{
                        
                    }.frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    PrimaryButton(buttonText: "Start Exam", action: {})
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        .padding(.top, 16)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 20,
                            topTrailingRadius: 20
                        )
                    ))
                
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(viewModel.selectedColor))
                .ignoresSafeArea(edges: .top)
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

#Preview {
    ExamDescriptionScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
