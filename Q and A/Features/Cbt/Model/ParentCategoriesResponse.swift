//
//  ParentCategoriesResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 10/04/2026.
//

import Foundation


struct ParentCategoriesResponse: Codable{
    
    let status: Bool
    let message: Bool
    let data: [DataModel]
}


struct DataModel: Codable {
    let cbcId: String
    let isCat: Bool
    let item: String
    let isActive: Bool
    let isMock: String
    let level: String
    var catData: CatData?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey{
        case cbcId = "cbc_id"
        case isCat = "is_cat"
        case item
        case isActive = "is_active"
        case isMock = "is_mock"
        case level
        case catData = "cat_data"
        case createdAt = "created_at"
        
    }
}

struct CatData: Codable {
    var cbtId: String
    let subcat: [Subcat]
    let isActive: Bool
    let createdAt: String
    let maxExams: Int
    let examType: String
    let subcatType: String
    let image: String?
    let maxAttempt: Int
    let disablePractice: Bool
    let disableReview: Bool
    let hasObjective: Bool
    let hasTheory: Bool
    let isMock: Bool
    let minimumPurchase: Int
    let mockDescription: String
    let startDate: String?
    let endTime: String
    let startTime: String
    let mockParent: MockParent?
    let prizeMoney: Int
    let sponsor: Sponsor
    
    enum CodingKeys: String, CodingKey{
        case cbtId  = "cbt_id"
        case subcat
        case isActive = "is_active"
        case createdAt = "created_at"
        case maxExams = "max_exams"
        case examType = "exam_type"
        case subcatType = "subcat_type"
        case image
        case maxAttempt = "max_attempt"
        case disablePractice = "disable_practice"
        case disableReview = "disable_review"
        case hasObjective = "has_objective"
        case hasTheory = "has_theory"
        case isMock = "is_mock"
        case minimumPurchase = "minimum_purchase"
        case mockDescription = "mock_description"
        case startDate = "start_date"
        case endTime = "end_time"
        case startTime = "star_time"
        case mockParent = "mock_parent"
        case prizeMoney = "prize_money"
        case sponsor
        
    }
}

struct Subcat: Codable {
    let cbtId: String
    let createdAt: String
    let isActive: Bool
    let subcatId: String
    let title: String
    
    enum CodingKeys: String, CodingKey{
        case cbtId = "cbt_id"
        case createdAt = "created_at"
        case isActive = "is_active"
        case subcatId = "subcat_id"
        case title
    }
}

struct MockParent: Codable{
    let id: String
    let title: String
    let parent: String
    
}

struct Sponsor: Codable {
    let id: String
    let name: String
    let website: String?
    let facebook: String?
    let instagram: String?
    let twitter: String?
    let tiktok: String?
    let linkedin: String?
    let createdAt: String
    let sponsorImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case website
        case facebook
        case instagram
        case twitter
        case tiktok
        case linkedin
        case createdAt = "created_at"
        case sponsorImage = "sponsor_image"
    }
}
,
