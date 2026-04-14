//
//  MainCbtScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI

struct MainCbtScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    let onShowNavDrawer: () -> Void
    @StateObject var viewModel: MainCbtViewModel = .init()
    @StateObject var cbtViewModel: CbtViewModel = .init()
    
    
    let columns = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    
    var body: some View {
        
        VStack{
            
            HStack(){
                
                Button(){
                    
                }label: {
                    Image("hamburger")
                }
                
                TextField("Search CBT..", text: .constant(""))
                    .padding(.leading,16)
                    .padding(.trailing,16)
                    .textFieldStyle(.roundedBorder)
                    
                
                Button(){
                    
                }label: {
                    Image("info")
                }
                
                Button(){
                    
                    
                }label: {
                    Image("cart")
                }.padding(.leading, 8)
                
            }.frame(maxWidth: .infinity)
             .padding(.leading, 16)
             .padding(.trailing, 16)
            
            
            ZStack(){
                
                if(viewModel.state.isLoading){
                   
                    ProgressView()
                    
                }else{
                    if(viewModel.state.errorMessage != nil){
                        
                        ErrorView(message: viewModel.state.errorMessage!){
                            viewModel.loadData()
                        }
                       
                    }else{
                       
                        VStack{
                            
                            Spacer().frame(height: 35)
                            
                            
                                LazyVGrid(columns: columns, spacing: 20){
                                    ForEach(viewModel.state.items){item in
                                        MainCbtItemView(item: item){
                                            handleItemClick(item: item.data)
                                        }
                                    }
                                }.padding(.leading, 16)
                                 .padding(.trailing, 16)
                                
                            
                            
                            Spacer()
                            
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        
                        
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear{
                    viewModel.loadData()
                }
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    private func handleItemClick(item: DataModel){
        if(!item.isCat){
            
        }else{
            if(item.catData?.isMock == true){
                cbtViewModel.parentCategoriesData = item
                cbtViewModel.mockCatData = item
                moveToMockExam()
            }
            else if (item.catData?.subcat.isEmpty ?? true){
                cbtViewModel.parentCategoriesData = item
                moveToCatPage()
            }else{
                cbtViewModel.parentCategoriesData = item
                moveToSubCatPage()
            }
        }
        
    }
    
    private func moveToSubCatPage(){
        navVm.navigate(route: .examSubCatScreen)
    }
    
    private func moveToMockExam(){
        navVm.navigate(route: .mockDescriptionScreen)
    }
    
    private func moveToCatPage(){
        navVm.navigate(route: .examCatScreen)
    }
}

#Preview {
    MainCbtScreen(navVm: MainNavViewModel(), onShowNavDrawer: {})
}
