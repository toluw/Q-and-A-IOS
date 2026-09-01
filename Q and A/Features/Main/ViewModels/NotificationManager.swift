//
//  NotificationManager.swift
//  Q and A
//
//  Created by GIGL-PC on 01/09/2026.
//

import Foundation


import Foundation
import UIKit
import FirebaseMessaging
import UserNotifications

/// Single source of truth for push state, observable by SwiftUI views.
@MainActor
final class NotificationManager: ObservableObject {

    static let shared = NotificationManager()

    @Published private(set) var fcmToken: String?
    @Published private(set) var authorizationStatus: UNAuthorizationStatus = .notDetermined
    
    /// When non-nil, the priming dialog for this reason should be shown.
       /// Set via `presentPrimer(for:)`, consumed by the view via `.alert(item:)`.
       @Published var presentedPrimerReason: NotificationPrimerReason?
    
    
    private let service: MainServiceProtocol
    
    
      
      init(service:  MainServiceProtocol = MainService()) {
          self.service = service
          Task { await refreshAuthorizationStatus() }
      }
    
    
    
    func presentPrimerIfNeeded(for reason: NotificationPrimerReason) {
           Task {
               await refreshAuthorizationStatus()
               guard authorizationStatus == .notDetermined else { return }
               await MainActor.run {
                   presentedPrimerReason = reason
               }
           }
       }
    
       /// Called when the user taps "Turn On" in the priming dialog.
       func confirmPrimerRequest() {
           presentedPrimerReason = nil
           Task { await requestAuthorization() }
       }
    
       /// Called when the user dismisses/declines the priming dialog.
       func dismissPrimer() {
           presentedPrimerReason = nil
       }
    

   

    // MARK: - Permission

    /// Call this from a view (e.g. onboarding screen, or a settings toggle) — NOT
    /// automatically at launch, so you control when the system prompt appears.
    @discardableResult
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge])

            if granted {
                await MainActor.run { UIApplication.shared.registerForRemoteNotifications() }
            }
            await refreshAuthorizationStatus()
            return granted
        } catch {
            print("❌ Notification authorization error: \(error.localizedDescription)")
            return false
        }
    }

    func refreshAuthorizationStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        authorizationStatus = settings.authorizationStatus
    }

    // MARK: - Token

    /// Called by AppDelegate.messaging(_:didReceiveRegistrationToken:)
    func updateToken(token: String) {
        fcmToken = token
        UserSettings.token = token
        let email = UserSettings.email ?? ""
        if(!email.isEmpty){
          syncTokenWithBackend(token: token, email: email)
        }
    }

    /// Replace this with your actual API call, tied to the authenticated user.
    private func syncTokenWithBackend(token: String, email: String){
        Task{
            do{
               
              let updateTokenBody = UpdateTokenBody(ios_token: token, email: email)
                try await service.updateToken(updateTokenBody: updateTokenBody)
                
            }catch{
                
               print("network error \(error.localizedDescription)")
                
            }
            
        }
    }
    
    
    

    // MARK: - Topics

    func subscribe(toTopic topic: String) {
        Messaging.messaging().subscribe(toTopic: topic) { error in
            if let error {
                print("❌ Failed to subscribe to \(topic): \(error.localizedDescription)")
            } else {
                print("✅ Subscribed to topic: \(topic)")
            }
        }
    }

    func unsubscribe(fromTopic topic: String) {
        Messaging.messaging().unsubscribe(fromTopic: topic) { error in
            if let error {
                print("❌ Failed to unsubscribe from \(topic): \(error.localizedDescription)")
            } else {
                print("✅ Unsubscribed from topic: \(topic)")
            }
        }
    }

    // MARK: - Badge

    func clearBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}
