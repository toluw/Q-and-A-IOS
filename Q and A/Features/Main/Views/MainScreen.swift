//
//  MainScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 25/03/2026.
//

import SwiftUI
import GoogleSignIn

struct MainScreen: View {
    
    
    @State private var selectedTab: MainTab = .cbt
    @State private var isDrawerOpen = false
    
    @StateObject private var viewModel = MainScreenViewModel()
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    
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
                   
                },
                navVM: navVm
                
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
        VStack {
                   
                   // Current Screen
            contentView.padding(.bottom,30)
            
                  Spacer()
            
                   // Bottom Navigation
                   VStack {
                      
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
               MainCbtScreen(navVm: navVm, cbtViewModel: cbtViewModel,onShowNavDrawer: openDrawer){data in
                   viewModel.userProfileState = data
               }
                   
               
           case .contact_us:
               ContactUsScreen()
           
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
            
        case .cbtHistory:
             cbtHistory()
        case .paymentHistory:
            paymentHistory()
        case .privacyPolicy:
            privacyPolicy()
        case .deactivateAccount:
            deactivateAccount()
        }
    }
    
    
    private func privacyPolicy(){
        if let url = URL(string: privacyUrl){
            UIApplication.shared.open(url)
        }
    }
    
    private func paymentHistory(){
        navVm.navigate(route: .userPaymentScreen)
    }
    
    private func cbtHistory(){
        navVm.navigate(route: .cbtHistoryScreen)
    }
    
    private func deactivateAccount(){
        
    }
    
    private func moveToEditProfile(){
        
    }
    
    private func about(){
        navVm.navigate(route: .aboutScreen)
    }
    
    private func termsAndConditions(){
        if let url = URL(string: termsUrl){
            UIApplication.shared.open(url)
        }
        
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
            
            GIDSignIn.sharedInstance.signOut()
            
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
    MainScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
