//
//  Reply.swift
//  Q and A
//
//  Created by GIGL-PC on 08/08/2026.
//

import Foundation

struct Reply: Codable, Equatable, Identifiable, Hashable {
    let commentId: String
    let content: String
    let createdAt: String
    let email: String
    var hasLiked: Bool
    let id: String
    let image: String?
    let isActive: Bool
    let isEdited: Bool
    var numLikes: Int
    let numViews: Int
    let reason: String
    let user: User
    let quote: Quote?
    var truncateText: Bool = true
    

    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case content
        case createdAt = "created_at"
        case email
        case hasLiked = "has_liked"
        case id
        case image
        case isActive = "is_active"
        case isEdited = "is_edited"
        case numLikes = "num_likes"
        case numViews = "num_views"
        case reason
        case user
        case quote
        
        
    }
    
    static let preview = Reply(commentId: "2", content: "When are you coming. I will like to meet with you. Please bring Tolu along with you. It is raining over here", createdAt: "2023-07-15 13:02:32", email: "oke@gmail.com", hasLiked: true, id: "5", image: nil, isActive: true, isEdited: true, numLikes: 4, numViews: 8, reason: "", user: User(created: "2023-07-15 13:02:32", deviceId: "495skd03", email: "oketoluwase@gmail.com", id: "19", name: "James Justin", phone: "0904050030", token: "", image: ""), quote: Quote(name: "James Justin", content: "Bring me a flavored milk and I will love you forever. Damn it"))
}
