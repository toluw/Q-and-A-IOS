//
//  MainCbtScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI

struct MainCbtScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    let onShowNavDrawer: () -> Void
    let onLoginSucces: (UserProfile) -> Void
    @StateObject var viewModel: MainCbtViewModel = .init()
    
    
    
    let columns = [
            GridItem(.flexible(), spacing: 21),
            GridItem(.flexible(), spacing: 21)
        ]
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                HStack(){
                    
                    Button(){
                        onShowNavDrawer()
                    }label: {
                        Image("hamburger")
                    }
                    
                    Spacer()
               
                    Text("CBT Categories").font(AppFont.semi_bold(18))
                    
                    Spacer()
                        
                    
                   
                    
                    CartView(){
                        navVm.navigate(route: .cbtCartScreen)
                    }.padding(.leading, 8)
                    
                }.frame(maxWidth: .infinity)
                 .padding(.leading, 21)
                 .padding(.trailing, 21)
                 .padding(.top,10)
                
                
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
                                
                                Spacer().frame(height: 40)
                                
                                
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
                    
                
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if viewModel.state.showBlockedLoader {
                   Color.black.opacity(0.4)
                       .ignoresSafeArea()
                   
                   ProgressView()
                       .padding()
                       .background(Color.white)
                       .cornerRadius(10)
               }
            
            
        }.onAppear{
            viewModel.loadData()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
         .sheet(isPresented: $viewModel.showLogin){
                LoginScreen(
                    onDismiss: {
                        viewModel.showLogin = false
                    }, onForgotpassword: {
                        viewModel.showLogin = false
                        navVm.navigate(route: .forgotPasswordScreen)
                    }, onLoginSuccess: {userProfile in
                        viewModel.showLogin = false
                        onLoginSucces(userProfile)
                        showSuccessMessage(message: "Thanks \(userProfile.name)! You are now logged in", actionTitle: "Continue", showCancel: false){
                            
                        }
                       
                    },
                    navVM: navVm
                    
                )
            }
         .sheet(isPresented: $viewModel.state.showCatBottomSheet){
             
             if(viewModel.state.parentCatData != nil){
                 CbtCategoryBottomSheetView(items: viewModel.state.parentCatData!){data in
                     viewModel.state.showCatBottomSheet = false
                     handleCatSelection(item: data)
                 } 
                 .presentationDetents([.large])
                     
                 
             }
             
         }
        
        
       
        
    }
    
    private func handleCatSelection(item: DataModel){
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
    
    private func handleItemClick(item: DataModel){
        if(!item.isCat){
            print("nav_result", "item not cat")
            viewModel.getParentCatData(level: item.level, cbcId: item.cbcId, isMock: item.isMock)
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
    MainCbtScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), onShowNavDrawer: {}, onLoginSucces: {data in
        
    })
}
