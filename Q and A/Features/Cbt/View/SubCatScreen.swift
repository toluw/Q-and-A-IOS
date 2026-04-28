//
//  SubCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/04/2026.
//

import SwiftUI

struct SubCatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @StateObject var viewModel: SubCatViewModel = .init()
    
    var body: some View {
        
        
        ZStack{
            
            if(viewModel.state.isLoading){
                
                ProgressView()
                
            }else{
                if(viewModel.state.errorMessage != nil){
                    
                    ErrorView(message: viewModel.state.errorMessage!){
                        if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                            viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                           }
                    }
                    
                }else if(viewModel.state.items.isEmpty){
                    
                    EmptyStateView(title: viewModel.state.emptyStateText)
                        .padding(.leading, 16)
                        .padding(.trailing,16)
                    
                }else{
                    
                    ScrollView{
                        
                        LazyVStack(spacing: 0){
                            
                            VStack{
                               
                                Text("Select preffered \(cbtViewModel.parentCategoriesData?.catData?.subcatType.lowercased() ?? "")")
                                    .font(AppFont.regular(16))
                                    .padding(.top, 16)
                                
                                
                                TextField("Search \(cbtViewModel.parentCategoriesData?.catData?.subcatType.lowercased() ?? "")", text: $viewModel.state.searchText)
                                    .padding(.leading,20)
                                    .padding(.trailing,20)
                                    .padding(.top, 12)
                                    .padding(.bottom, 12)
                                    .textFieldStyle(.roundedBorder)
                                
                            }.frame(maxWidth: .infinity)
                                .background(.white)
                            
                         
                            
                            
                            ForEach(viewModel.state.items.indices, id: \.self) { index in
                                   
                                   if let catData = cbtViewModel.parentCategoriesData?.catData {
                                       SubCatExamItemView(
                                           subCatExam: $viewModel.state.items[index],
                                           catData: catData,
                                           viewModel: viewModel,
                                           position: index
                                       )
                                   }
                               
                        }
            
                        .padding(.leading, 16)
                            .padding(.trailing, 16)
                            .padding(.top, 30)
                        
                        Spacer()
                                .frame(height: 170)
                            
                            
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("list_bg"))
                    
                }
                
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
          .onAppear{
                    viewModel.reInitExamSelection()
                    
                 if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                     viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                    }
                    
                }
        
        
        
        
    }
}

#Preview {
    SubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
