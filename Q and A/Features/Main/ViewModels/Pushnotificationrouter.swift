//
//  Pushnotificationrouter.swift
//  Q and A
//
//  Created by GIGL-PC on 01/09/2026.
//
import Foundation
import Combine



/// Parses raw APNs/FCM payloads and exposes a destination for the SwiftUI
/// navigation layer to consume. AppDelegate feeds this; views observe it.
@MainActor
final class PushNotificationRouter: ObservableObject {

    static let shared = PushNotificationRouter()

    /// Set when a notification is tapped; a view (e.g. root NavigationStack) should
    /// observe this, navigate, then reset it to `.none`.
    @Published var pendingDestination: MainRoute = .none

    private init() {}

    func handle(userInfo: [AnyHashable: Any], launchedFromTap: Bool) {
        // Example expected payload shape (custom "data" keys you define server-side):
        // {
        //   "aps": { "alert": { "title": "...", "body": "..." }, "sound": "default" },
        //   "type": "post",
        //   "postId": "abc123"
        // }

        guard launchedFromTap else {
            // Received while foregrounded/backgrounded but not tapped — log/update
            // badge/refresh data here if needed, but don't navigate.
            print("ℹ️ Push received (no navigation): \(userInfo)")
            return
        }

        guard let type = userInfo["type"] as? String else {
            pendingDestination = .none
            return
        }

        switch type {
        case "post":
            if let postId = userInfo["post_id"] as? String {
                pendingDestination = .commentScreen(post: nil, postId: postId, showKeyPad: false)
            }
        case "comment":
            if let commentId = userInfo["comment_id"] as? String {
                pendingDestination = .replyScreen(comment: nil, commentId: commentId, showKeyPad: false)
            }
        default:
            pendingDestination = .none
        }
    }

    func consumeDestination() {
        pendingDestination = .none
    }
}
