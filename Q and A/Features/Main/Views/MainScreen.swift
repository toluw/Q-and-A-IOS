//
//  MainScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 25/03/2026.
//

import SwiftUI

struct MainScreen: View {
    
    
    @State private var selectedTab: MainTab = .cbt
    @State private var isDrawerOpen = false
    
    @StateObject private var viewModel = MainScreenViewModel()
    @ObservedObject var navVm: MainNavViewModel
    
    
    var body: some View {
        ZStack {
                   
            // Main Content
            mainContent
                .disabled(isDrawerOpen)
                .blur(radius: isDrawerOpen ? 3 : 0)
            
            
            // Overlay
             if isDrawerOpen {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                            closeDrawer()
                        }
                        .transition(.opacity)
                }
            
           
            // Drawer
            HStack {
                NavDrawer(onMenuSelected: handleMenuSelection, mainScreenViewModel: viewModel)
                .frame(width: 300)
                .offset(x: isDrawerOpen ? 0 : -320)
                            
                Spacer()
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
                    viewModel.userProfileState = userProfile
                 //   viewModel.loginSuccessMessage = ToastData(message: "Thanks
                    // \(userProfile.name)! You are now logged in", type: .success)
                    showSuccessMessage(message: "Thanks \(userProfile.name)! You are now logged in", actionTitle: "Continue", showCancel: false){
                        
                    }
                   
                }
                
            )
        }
        .toastBanner(toast: $viewModel.logoutMessage)
        .onAppear{
            viewModel.reInitUserProfile()
        }
        .animation(.easeInOut(duration: 0.3), value: isDrawerOpen)
         .environmentObject(viewModel)
    }
    
    @ViewBuilder
    private var mainContent: some View{
        ZStack {
                   
                   // Current Screen
                   contentView
                   
                   // Bottom Navigation
                   VStack {
                       Spacer()
                       CustomBottomNav(
                        selectedTab: $selectedTab,
                        onFabClick: {
                           
                       })
                   }
               }
    }
    
    
    @ViewBuilder
       private var contentView: some View {
           switch selectedTab {
           case .cbt:
               MainCbtScreen(navVm: navVm, onShowNavDrawer: openDrawer){data in
                   viewModel.userProfileState = data
               }
                   
               
           case .book:
               MainBookScreen()
           case .video:
               MainVideoScreen()
           case .library:
               MainLibraryScreen()
           }
       }
    
    
    private func openDrawer() {
            isDrawerOpen = true
    }
        
    private func closeDrawer() {
            isDrawerOpen = false
    }
    
    private func handleMenuSelection(navMenu: NavMenu){
        
        closeDrawer()
        
        switch (navMenu){
            
        case .community: moveToCommunity()
            
        case .aiAssistance: moveToAiAssistance()
        
        case .fanQuiz: moveToFanQuiz()
        
        case .myLibrary: moveToLibrary()
            
        case .myCbt: moveToMyCbt()
            
        case .myPortal: moveToPortal()
            
        case .shareApp: shareApp()
            
        case .myCart: moveToMyCart()
            
        case .signOut: signOut()
            
        case .signIn: signIn()
            
        case .reportCopyright: reportCopyright()
            
        case .contactUs: contactUs()
            
        case .faq: moveToFaq()
            
        case .termsAndConditions: termsAndConditions()
            
        case .about: about()
            
        case .editProfile: moveToEditProfile()
            
        }
    }
    
    
    private func moveToEditProfile(){
        
    }
    
    private func about(){
        
    }
    
    private func termsAndConditions(){
        
    }
    
    private func moveToFaq(){
        
    }
   
    private func contactUs(){
        
    }
    
    private func reportCopyright(){
        
    }
    
    private func signIn(){
        viewModel.showLogin = true
    }
    
    private func signOut(){
        showNoticeMessage(message: "Are you sure you want to Sign out?", actionTitle: "Sign Out"){
            UserSettings.name  = ""
            UserSettings.email = ""
            UserSettings.phoneNumber = ""
            UserSettings.profileImage = ""
            UserSettings.isLoggedIn = false
            
            viewModel.userProfileState = UserProfile()
            
            viewModel.logoutMessage = ToastData(message:  "You have been successfully logged out", type: .success)
            
            
        }
    }
    
    private func moveToMyCart(){
        
    }
    
    private func shareApp(){
        
    }
    
    private func moveToPortal(){
        
    }
    
    private func moveToMyCbt(){
        
    }
    
    private func moveToLibrary(){
        
    }
    
    private func moveToFanQuiz(){
        
    }
    
    private func moveToAiAssistance(){
        
    }
    
    private func moveToCommunity(){
        
    }
    
    
    
}

#Preview {
    MainScreen(navVm: MainNavViewModel())
}
