//
//  ParentCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 14/04/2026.
//

import SwiftUI

struct ParentCatScreen: View {
    
    let title: String
    let cbcId: String
    let level: String
    let isMock: String
    
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @StateObject var viewModel: ParentCatViewModel = .init()

        
    
    var body: some View {
        
        VStack{
            
        /*  HStack{
               
                Spacer()
                
                Text(title).font(AppFont.regular(18))
                
                Spacer()
                
                CartView(){
                    
                }.padding(.leading, 8)
          
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 16)
                .padding(.trailing, 16)  */
            
            TextField("Search..", text: $viewModel.state.searchTxt)
                .padding(.leading,16)
                .padding(.trailing,16)
                .padding(.top, 12)
                .textFieldStyle(.roundedBorder)
            
            
            ZStack{
                
                if(viewModel.state.isLoading){
                    
                    ProgressView()
                    
                }else{
                    
                    if(viewModel.state.errorMessage != nil){
                        ErrorView(message: viewModel.state.errorMessage!){
                            Task{
                               await viewModel.getParentCatData(level: level, cbcId: cbcId, isMock: isMock)
                            }
                            
                        }
                    }else if(viewModel.state.parentCatData.isEmpty){
                        
                        EmptyStateView(title: viewModel.state.emptyStateText)
                            .padding(.leading, 16)
                            .padding(.trailing,16)
                        
                    }else{
                        ScrollView{
                            LazyVStack(spacing: 22){
                                ForEach(viewModel.state.parentCatData){ data in
                                    CatItemView(title: data.item, onItemClicked: {
                                        handleItemClick(item: data)
                                    })
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(.leading, 16)
                            .padding(.trailing, 16)
                            .padding(.top, 30)
                    }
                    
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
            
        }
        .toolbar {
            
            // Title
            ToolbarItem(placement: .principal) {
                Text(title).font(AppFont.regular(18))
            }
            
            // Trailing Icon
            ToolbarItem(placement: .navigationBarTrailing) {
                CartView(){
                    navVm.navigate(route: .cbtCartScreen)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("list_bg"))
            .task {
                
                guard case .parentCatScreen = navVm.activeRoute else {
                    return
                }
                
                await viewModel.getParentCatData(level: level, cbcId: cbcId, isMock: isMock)
            }
            .onChange(of: viewModel.state.searchTxt){oldValue, newValue in
                if(newValue == ""){
                    viewModel.state.parentCatData = viewModel.state.defaultData
                }else{
                    
                    let searchData = viewModel.state.defaultData.filter {
                        $0.item.lowercased().contains(newValue.lowercased())
                    }
                    
                    viewModel.state.parentCatData = searchData
                    
                    if(searchData.isEmpty){
                        viewModel.state.emptyStateText = "No search result for \(newValue)"
                    }
                    
                    
                    
                }
            }
            .sheet(isPresented: $viewModel.showLogin){
                   LoginScreen(
                       onDismiss: {
                           viewModel.showLogin = false
                       }, onForgotpassword: {
                           viewModel.showLogin = false
                           navVm.navigate(route: .forgotPasswordScreen)
                       }, onLoginSuccess: {userProfile in
                           viewModel.showLogin = false
                           showSuccessMessage(message: "Thanks \(userProfile.name)! You are now logged in", actionTitle: "Continue", showCancel: false){
                               
                           }
                          
                       },
                       navVM: navVm
                       
                   )
               }
        
    }
    
    
    private func handleItemClick(item: DataModel){
        viewModel.state.searchTxt = ""
        if(!item.isCat){
            cbtViewModel.parentCategoriesData = item
            moveToParentCatPage(title: item.item , cbcId: item.cbcId, level: item.level, isMock: item.isMock)
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
    
    
    private func moveToParentCatPage(title: String, cbcId: String, level: String, isMock: String){
        navVm.navigate(route: .parentCatScreen(title: title, cbcId: cbcId, level: level, isMock: isMock))
    }
    
    private func moveToSubCatPage(){
        navVm.navigate(route: .examSubCatScreen)
    }
    
    private func moveToMockExam(){
        if(UserSettings.isLoggedIn){
            navVm.navigate(route: .mockDescriptionScreen)
        }else{
            showNoticeMessage(message:  "You must be logged in to proceed", actionTitle: "Login", showCancel: true){
                viewModel.showLogin = true
            }
        }
        
    }
    
    private func moveToCatPage(){
        navVm.navigate(route: .examCatScreen)
    }
}

#Preview {
    
    
   
    
    ParentCatScreen(title: "Education", cbcId: "1", level: "2", isMock: "1", navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())

}
