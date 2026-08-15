//
//  Q_and_AApp.swift
//  Q and A
//
//  Created by GIGL-PC on 22/01/2026.
//

import SwiftUI
import SwiftData
import FirebaseCore
import GoogleSignIn


@main
struct Q_and_AApp: App {
    
    @StateObject private var appViewModel = AppViewModel()
    
    init() {
           FirebaseApp.configure()
       }
    
    
     var body: some Scene {
        WindowGroup {
            AppNavigator()
                .environmentObject(appViewModel)
                .preferredColorScheme(.light)
                .globalBottomSheet()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }.modelContainer(for: ExamCart.self)
    }
}
