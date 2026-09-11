//
//  NotificationPrimerReason.swift
//  Q and A
//
//  Created by GIGL-PC on 01/09/2026.
//

import Foundation

/// Each case represents one place in the app where we ask a user to opt in to
/// push notifications, right after an action that makes the value obvious.
/// Add new cases here as new scenarios come up — everything else (dialog,
/// request flow) is driven off this.
enum NotificationPrimerReason: String, Identifiable {
    case newPost
    case newComment

    var id: String { rawValue }

    var title: String {
        switch self {
        case .newPost:
            return "Get notified about comments"
        case .newComment:
            return "Get notified about replies"
        }
    }

    var message: String {
        switch self {
        case .newPost:
            return "Turn on notifications to know as soon as someone comments on your post."
        case .newComment:
            return "Turn on notifications to know as soon as someone replies to your comment."
        }
    }

    /// Button label offering to enable — kept per-case in case copy needs to diverge later.
    var confirmActionTitle: String {
        "Turn On"
    }
}
