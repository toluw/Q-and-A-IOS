//
//  Post.swift
//  Q and A
//
//  Created by GIGL-PC on 13/07/2026.
//

import Foundation

struct Post: Codable {
    let content: String
    let title: String
    let createdAt: String
    let email: String
    let examId: String?
    var hasLiked: Bool
    let id: String
    let image: String?
    let isActive: Bool
    let isEdited: Bool
    let numComment: Int
    var numLikes: Int
    let numViews: Int
    let questionId: String?
    let reason: String
    let status: String
    let user: User
    let parent: String?
    let parentId: String?
    let categoryId: String?
    let expiry: String?
    let link: String
    
    static let preview = Post(
        content: "There was a girl named Joke. She is five years old. Sha has five sisters and a friend and very brittle", title: "The Girl Named Joke", createdAt: "2023-07-15 13:02:32", email: "oketoluwase@gmail.com", examId: "3", hasLiked: true, id: "35", image: nil, isActive: true, isEdited: true, numComment: 8, numLikes: 2, numViews: 9, questionId: "30", reason: "", status: "", user: User(created: "2023-07-15 13:02:32", deviceId: "", email: "oketoluwase@gmail.com", id: "3", name: "James Justin", phone: "08055578829", token: "", image: ""), parent: nil, parentId: nil, categoryId: nil, expiry: nil, link: ""
    )

    enum CodingKeys: String, CodingKey {
        case content
        case title
        case createdAt = "created_at"
        case email
        case examId = "exam_id"
        case hasLiked = "has_liked"
        case id
        case image
        case isActive = "is_active"
        case isEdited = "is_edited"
        case numComment = "num_comment"
        case numLikes = "num_likes"
        case numViews = "num_views"
        case questionId = "question_id"
        case reason
        case status
        case user
        case parent
        case parentId = "parent_id"
        case categoryId = "category_id"
        case expiry
        case link
    }
}
