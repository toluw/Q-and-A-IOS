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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
      @StateObject private var notificationManager = NotificationManager.shared
      @StateObject private var router = PushNotificationRouter.shared
    
     var body: some Scene {
        WindowGroup {
            AppNavigator()
                .environmentObject(appViewModel)
                .environmentObject(notificationManager)
                .environmentObject(router)
                .onAppear {
                    notificationManager.clearBadge()
                    }
                .preferredColorScheme(.light)
                .globalBottomSheet()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }.modelContainer(for: ExamCart.self)
    }
}
