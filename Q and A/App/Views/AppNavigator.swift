//
//  AppNavigator.swift
//  Q and A
//
//  Created by GIGL-PC on 28/01/2026.
//

import SwiftUI



struct AppNavigator: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var updateManager = UpdateManager()
    @State private var showDialog = false
    
    var body: some View {
        
        ZStack{
         
            switch appViewModel.appFlow {
            case .splash:
                SplashView()
            case .intro:
                OnboardingNavigatorView()
            case.main:
                MainStackView()
            }
            
            
        }.task {
            await updateManager.checkForUpdate()
        }.onChange(of: updateManager.updateStatus) { _, newStatus in
            switch newStatus {
            case .none:
                showDialog = false
            default:
                showDialog = true
            }
        }
        .fullScreenCover(isPresented: $showDialog) {
            switch updateManager.updateStatus {
            case .forced(let message, let url):
                UpdateDialogView(
                    title: "Update Required",
                    message: message,
                    updateURL: url,
                    isForced: true
                )
                .background(ClearBackgroundView())

            case .optional(let message, let url):
                UpdateDialogView(
                    title: "Update Available",
                    message: message,
                    updateURL: url,
                    isForced: false,
                    onDismiss: { showDialog = false }
                )
                .presentationBackground(.clear)

            case .none:
                EmptyView()
            }
        }
        
       
        
    }
}



#Preview {
    AppNavigator()
        .environmentObject(AppViewModel())
}
