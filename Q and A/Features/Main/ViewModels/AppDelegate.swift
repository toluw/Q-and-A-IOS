//
//  AppDelegate.swift
//  Q and A
//
//  Created by GIGL-PC on 01/09/2026.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

/// Bridges UIKit-era push/APNs callbacks into the SwiftUI app lifecycle.
/// Owned via @UIApplicationDelegateAdaptor in the App struct.
final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    // MARK: - Launch

    func application(_ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        FirebaseApp.configure()

        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        // If the app was launched from a tapped notification (cold start), capture it.
        if let remoteNotification = launchOptions?[.remoteNotification] as? [AnyHashable: Any] {
            PushNotificationRouter.shared.handle(userInfo: remoteNotification, launchedFromTap: true)
        }

        return true
    }

    // MARK: - APNs token → hand off to Firebase

    func application(_ application: UIApplication,
                      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication,
                      didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for remote notifications: \(error.localizedDescription)")
    }

    // MARK: - Data-only / silent push (background fetch)
    // Called when a push has "content-available": 1 and no "alert" key, or when
    // the app is backgrounded and a data-only message arrives.

    func application(_ application: UIApplication,
                      didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                      fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PushNotificationRouter.shared.handle(userInfo: userInfo, launchedFromTap: false)
        completionHandler(.newData)
    }

    // MARK: - FCM registration token

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken else { return }
        print("✅ FCM registration token: \(fcmToken)")
        NotificationManager.shared.updateToken(token: fcmToken)
    }

    // MARK: - Foreground presentation
    // Without this, notifications are silently swallowed while the app is in the foreground.

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 willPresent notification: UNNotification,
                                 withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        PushNotificationRouter.shared.handle(userInfo: userInfo, launchedFromTap: false)
        completionHandler([.banner, .list, .sound, .badge])
    }

    // MARK: - User tapped a notification (from background or after cold start)

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 didReceive response: UNNotificationResponse,
                                 withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        PushNotificationRouter.shared.handle(userInfo: userInfo, launchedFromTap: true)
        completionHandler()
    }
}
