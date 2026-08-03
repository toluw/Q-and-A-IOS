//
//  Comment.swift
//  Q and A
//
//  Created by GIGL-PC on 03/08/2026.
//

import Foundation

struct Comment: Codable {
    let content: String
    let createdAt: String
    let email: String
    var hasLiked: Bool
    let id: String
    let image: String?
    let isActive: Bool
    let isEdited: Bool
    var numLikes: Int
    let numReply: Int
    let numViews: Int
    let postId: String
    let reason: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case content
        case createdAt = "created_at"
        case email
        case hasLiked = "has_liked"
        case id
        case image
        case isActive = "is_active"
        case isEdited = "is_edited"
        case numLikes = "num_likes"
        case numReply = "num_reply"
        case numViews = "num_views"
        case postId = "post_id"
        case reason
        case user
    }
    
    static let preview = Comment(content: "Welcome on board. we are here to server you. https://www.google.com", createdAt: "2023-07-15 13:02:32", email: "seun@gmail.com", hasLiked: true, id: "3", image: nil, isActive: true, isEdited: true, numLikes: 5, numReply: 5, numViews: 5, postId: "4", reason: "", user: User(created: "2023-07-15 13:02:32", deviceId: "495skd03", email: "oketoluwase@gmail.com", id: "19", name: "James Justin", phone: "0904050030", token: "", image: ""))
}
